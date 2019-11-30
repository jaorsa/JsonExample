//
//  ViewAnimalController.swift
//  JsonExample
//
//  Created by Administrador on 29/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

var container: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(named: "Grass")
    view.layer.cornerRadius = 5
    
    view.addSubview(fechaLabel)
    fechaLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 170, height: 15)
    view.addSubview(fecha)
    fecha.anchor(top: view.topAnchor, left: fechaLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 8, height: 15)
    
    view.addSubview(hembrasLabel)
    hembrasLabel.anchor(top: fechaLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 150, height: 15)
    view.addSubview(hembras)
    hembras.anchor(top: fechaLabel.bottomAnchor, left: hembrasLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 60, paddingBottom: 0, paddingRight: 8, height: 15)
    
    view.addSubview(machosLabel)
    machosLabel.anchor(top: hembrasLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 150, height: 15)
    view.addSubview(machos)
    machos.anchor(top: hembrasLabel.bottomAnchor, left: machosLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 60, paddingBottom: 0, paddingRight: 8, height: 15)
    
    view.addSubview(saludLabel)
    saludLabel.anchor(top: machosLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 150, height: 15)
    view.addSubview(salud)
    salud.anchor(top: machosLabel.bottomAnchor, left: saludLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 60, paddingBottom: 0, paddingRight: 8, height: 15)
    
    view.addSubview(etapaLabel)
    etapaLabel.anchor(top: saludLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 170, height: 15)
    view.addSubview(etapa)
    etapa.anchor(top: saludLabel.bottomAnchor, left: saludLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 60, paddingBottom: 0, paddingRight: 8, height: 15)
    
    return view
}()

let camadaLabel: UILabel = {
   let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 25)
    label.text = "Camada X"
    label.textColor = UIColor(named: "ForestGreen")
    return label
}()

let fecha: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.text = ""
    label.textColor = UIColor(named: "Lime")
    return label
}()

let fechaLabel: UILabel = {
   let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.text = "Fecha de Nacimiento: "
    label.textColor = .white
    return label
}()

let hembras: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.text = ""
    label.textColor = UIColor(named: "Lime")
    return label
}()

let hembrasLabel: UILabel = {
   let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.text = "Hembras: "
    label.textColor = .white
    return label
}()

let machosLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.text = "Machos: "
    label.textColor = .white
    return label
}()

let machos: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.text = ""
    label.textColor = UIColor(named: "Lime")
    return label
}()

let saludLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.textColor = .white
    label.text = "Estado de Salud: "
    return label
}()

let salud: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.text = ""
    label.textColor = UIColor(named: "Lime")
    return label
}()

let etapaLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.textColor = .white
    label.text = "Etapa de crecimiento:"
    return label
}()

 let etapa: UILabel = {
     let label = UILabel()
     label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
     label.text = ""
     label.textColor = UIColor(named: "Lime")
     return label
 }()

class ViewAnimalController: UIViewController{
    
    let estadosalud = ["", "Saludable", "Enfermo"]
    let etapacrecimiento = ["", "Nacimiento", "Crecimiento", "Engorda"]
    var animal: Animal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(camadaLabel)
        camadaLabel.anchor(top: view.topAnchor,paddingTop: 60, height: 50)
        camadaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(container)
        container.anchor(top: camadaLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 30, paddingBottom: 50, paddingRight: 30, height: 250)
        setInitialValues()
    }
    
    func setInitialValues(){
        camadaLabel.text = animal?.name
        fecha.text = animal?.fechaNacimiento
        hembras.text = "\(animal!.no_h!)"
        machos.text = "\(animal!.no_m!)"
        salud.text = estadosalud[animal!.salud!]
        etapa.text = etapacrecimiento[animal!.etapa!]
    }
    
    
}
