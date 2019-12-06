//
//  MacawView.swift
//  BarChart
//
//  Created by Administrador on 22/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import Macaw
import UIKit

class MacawChartView: MacawView{
    
    static let showusers = createDummyData()
    static let maxValue = 500
    static let maxValueLineHeight = 180
    static let lineWidth: Double = 275
    
    static let dataDivisor = Double(maxValue/maxValueLineHeight)
    //var adjustedData: [Double]
    
    static let adjustedData: [Double] = showusers.map({ Double($0.estrellas!)/dataDivisor})
    
    static var animations: [Animation] = []
    
    
    required init?(coder aDecoder: NSCoder) {
            super.init(node: MacawChartView.createChart(),coder: aDecoder)
        backgroundColor = .white
    }
    
    private static func createChart() -> Group{
        var items: [Node] = addXAxisItems() + addYAxisItems()
        items.append(createBars())
        return Group(contents: items, place: .identity)
    }
    
    private static func addYAxisItems() -> [Node]{
        let maxLines = 7
        let lineInterval = Int(maxValue/maxLines)
        let yAxisHeight: Double = 200
        let lineSpacing: Double = 30
        
        var newNodes: [Node] = []
        
        for i in 1...maxLines{
            let y = yAxisHeight - (Double(i) * lineSpacing)
            
            let valueLine = Line(x1: -5, y1: y, x2: lineWidth, y2: y).stroke(fill: Color.gray.with(a: 0.25))
            let valueText = Text(text: "\(i * lineInterval)", align: .max, baseline: .mid, place: .move(dx: -10, dy: y))
            valueText.fill = Color.green
            
            newNodes.append(valueLine)
            newNodes.append(valueText)
        }
        let yAxis = Line(x1: 0, y1: 0, x2: 0, y2: yAxisHeight).stroke(fill: Color.gray.with(a: 0.35))
        newNodes.append(yAxis)
        return newNodes
    }
    
    private static func addXAxisItems() -> [Node]{
        let chartBaseY: Double = 200
        var newNodes: [Node] = []
        for i in 1...adjustedData.count{
            let x = (Double(i) * 50)
            let valueText = Text(text: (showusers[i-1].name)!, align: .max, baseline: .mid, place: .move(dx: x, dy: chartBaseY + 15))
            valueText.fill = Color.green
            newNodes.append(valueText)
        }
        let xAxis = Line(x1: 0, y1: chartBaseY, x2: lineWidth, y2: chartBaseY).stroke(fill: Color.gray.with(a: 0.35))
        
        newNodes.append(xAxis)
        return newNodes
    }
    
    private static func createBars() -> Group{
        let fill = LinearGradient(degree: 90, from: Color(val: 0xff4704), to: Color(val: 0xff4704).with(a: 0.33))
        let items = adjustedData.map{ _ in Group() }
        
        animations = items.enumerated().map{(i: Int, item: Group) in
            item.contentsVar.animation(delay: Double(i) * 0.1){ t in
                let height = adjustedData[i] * t
                let rect = Rect(x: Double(i) * 50 + 25, y: 200 - height, w: 30, h: height)
                return [rect.fill(with: fill)]
            }
        }
        return items.group()
    }
    
    static func playAnimations(){
        animations.combine().play()
    }
    
    
    private static func createDummyData()->[Usuarios]{
        var array = [Usuarios]()
        if teamusers == nil{
            let presuser = Usuarios(id: usuario!.id, name: usuario?.name, lastname: usuario?.lastname, correo: usuario?.correo, estrellas: usuario?.estrellas, admin: usuario?.admin, Roles: nil)
            array.append(presuser)
            return array
        }else{
            return teamusers!
        }
    }
}

