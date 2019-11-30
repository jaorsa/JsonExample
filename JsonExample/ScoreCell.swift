//
//  ScoreCell.swift
//  GranjApp
//
//  Created by Administrador on 27/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

//

import Foundation
import UIKit

class ScoreCell: UITableViewCell{
    var usuario: Usuarios?{
        didSet{
            profileNameLabel.text = usuario!.name! + " " + usuario!.lastname!
            scoreLabel.text = "Puntuacion: " + "\(usuario!.estrellas ?? 10)"
            profileImageView.image = #imageLiteral(resourceName: "user")
        }
    }
    
    var profileImageView: UIImageView = {
        let tmp = UIImageView()
        tmp.contentMode = .scaleAspectFill
        tmp.clipsToBounds = true
        tmp.translatesAutoresizingMaskIntoConstraints = false
        //tmp.image = #imageLiteral(resourceName: "images")
        return tmp
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        label.text = "etiqueta"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Default", size: 14)
        label.textColor = UIColor.lightGray
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
          let profileImageDimension: CGFloat = 30
                 
         addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0,paddingLeft: 10 ,paddingBottom: 0,paddingRight: 0, width: 25, height: 25)
        
        profileImageView.layer.cornerRadius = profileImageDimension / 2
         
        addSubview(profileNameLabel)
        profileNameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10,paddingLeft: 10 ,paddingBottom: 0,paddingRight: 0, height: 15)
        //profileNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addSubview(scoreLabel)
        scoreLabel.anchor(top: profileNameLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 3,paddingLeft: 20 ,paddingBottom: 0,paddingRight: 10, height: 20)
        
        
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
