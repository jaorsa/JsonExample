//
//  ApplicationCell.swift
//  JsonExample
//
//  Created by Administrador on 04/12/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCell: UITableViewCell{
    var recurso: Resource? {
        didSet{
            resourceLabel.text = recurso!.name
        }
    }
    /*
    var aplicacion: Applications?{
        didSet{
            dateLabel.text = aplicacion?.fecha
        }
    }*/
    
    //var resource: 
    
    let resourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.text = "etiqueta"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
           label.textColor = UIColor.lightGray
           label.text = "0"
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(resourceLabel)
        resourceLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10,paddingLeft: 10 ,paddingBottom: 0,paddingRight: 0, height: 30)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: resourceLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 3,paddingLeft: 20 ,paddingBottom: 0,paddingRight: 10, height: 15)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
