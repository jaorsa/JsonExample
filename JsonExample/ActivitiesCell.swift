//
//  ActivityCell.swift
//  GranjApp
//
//  Created by Administrador on 26/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit


protocol DeleteActivitiesDelegate{
    func deleteActivities(cell: ActivitiesCell)
}

var us: Usuarios?
class ActivitiesCell: UITableViewCell {
    var deleg: DeleteActivitiesDelegate?
    
    var activity: Activities?{
        didSet{
            ActivityLabel.text = activity?.name
            for i in 0...(teamusers?.count ?? 1)-1{
                if teamusers?[i].id == activity?.usuario{
                    
                        us = teamusers?[i]
                }
            }
            UserLabel.text = "Usuario asignado: " + (us?.name ?? ""
            )
        }
    }
    
    let ActivityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.text = "etiqueta"
        return label
    }()
    
    let UserLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        label.text = "etiqueta"
        return label
    }()
    
    
    
    let ActivityButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "check-box-empty"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(ActivityButton)
        let dimension: CGFloat = 45
        ActivityButton.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0,paddingLeft: 10 ,paddingBottom: 0,paddingRight: 0, width: dimension, height: dimension)
        ActivityButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ActivityButton.addTarget(self, action: #selector(done) , for: .touchUpInside)
        addSubview(ActivityLabel)
        ActivityLabel.anchor(top: nil, left: ActivityButton.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0,paddingLeft: 10 ,paddingBottom: 0,paddingRight: 10, width: dimension, height: 20)
        ActivityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        addSubview(UserLabel)
        UserLabel.anchor(top: ActivityLabel.bottomAnchor, left: ActivityButton.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 3,paddingLeft: 20 ,paddingBottom: 0,paddingRight: 10, width: dimension, height: 20)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func done(sender: UIButton!){
        print("Actividad ha sido realizada")
        ActivityButton.setImage( #imageLiteral(resourceName: "check-box"),for: .normal)
        deleg?.deleteActivities(cell: self)
        print("ejecutando...")
    }
    
    
}
