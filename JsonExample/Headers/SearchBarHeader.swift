//
//  SearchBarHeader.swift
//  GranjApp
//
//  Created by Administrador on 27/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

class SearchBarHeader: UIView{
    
    let searchBar = UISearchBar()
    
    let addUser: UIButton = {
        let button = UIButton()
        button.setTitle("Aceptar", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(named: "ForestGreen")
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "ForestGreen")
        addSubview(searchBar)
        
        searchBar.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: 270).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Ingrese el nombre de usuario que desea agregar"
        searchBar.barTintColor = UIColor(named: "ForestGreen")
        //searchBar.showsSearchResultsButton = true
        
        addSubview(addUser)
        addUser.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addUser.leftAnchor.constraint(equalTo: searchBar.rightAnchor, constant: 10).isActive = true
        addUser.widthAnchor.constraint(equalToConstant: 65).isActive = true
        addUser.heightAnchor.constraint(equalToConstant: 45).isActive = true
       
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
