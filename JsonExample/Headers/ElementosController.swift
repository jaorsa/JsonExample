//
//  ElementosController.swift
//  JsonExample
//
//  Created by Administrador on 20/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

class ElementosController: UIViewController{
    let siembraButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        //setTitle("Aceptar", for: .normal)
        button.backgroundColor = .brown
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.setTitle("Siembras", for: .normal)
        return button
    }()
    
    let recursosButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        //setTitle("Aceptar", for: .normal)
        button.backgroundColor = .green
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.setTitle("Recursos", for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(siembraButton)
        siembraButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 250, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, height: 100)
        siembraButton.addTarget(self, action: #selector(handleSiembras), for: .touchUpInside)
        
        
        view.addSubview(recursosButton)
        recursosButton.anchor(top: siembraButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, height: 100)
        recursosButton.addTarget(self, action: #selector(handleRecursos), for: .touchUpInside)
    }
    
    @objc func handleSiembras(){
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlantingViewController") as! PlantingViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleRecursos(){
        //let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResourceViewController") as! ResourceViewController
        //self.navigationController?.pushViewController(controller, animated: true)
    }

}
