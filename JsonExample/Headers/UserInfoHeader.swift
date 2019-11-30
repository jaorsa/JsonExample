//
//  UserInfoHeader.swift
//  GranjApp
//
//  Created by Administrador on 26/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

class UserInfoHeader: UIView{
    
    let profileImageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "user")
        return image
    }()
    
    let usernameLabel:UILabel = {
       let name = UILabel()
        name.text = usuario!.name! + " " + usuario!.lastname!
        name.font = UIFont(name: "AveirNext-DemiBold", size: 16)
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = usuario?.correo
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
            backgroundColor = UIColor(named: "ForestGreen")
           let profileImageDimension: CGFloat = 60
           
        
           addSubview(profileImageView)
           profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
           profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
           profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
           profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
           profileImageView.layer.cornerRadius = profileImageDimension / 2
           
           addSubview(usernameLabel)
           usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
           usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
           
           addSubview(emailLabel)
           emailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10).isActive = true
           emailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
    
}
