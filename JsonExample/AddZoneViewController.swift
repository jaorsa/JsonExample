//
//  AddZoneController.swift
//  GranjApp
//
//  Created by Administrador on 24/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

let zoneTextField: UITextField? = {
    let texf = UITextField()
    texf.placeholder = "Nombre de la zona"
    texf.textAlignment = .center
    texf.translatesAutoresizingMaskIntoConstraints = false
    return texf
}()



protocol AddZoneDelegate{
    func addZone(zone: [String:Any])
}

class AddAZoneViewController: UIViewController{
    var delegate: AddZoneDelegate?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finished))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(canceled))
        view.addSubview(zoneTextField!)
        zoneTextField!.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, height: 40)
        zoneTextField!.becomeFirstResponder()
    }
    
    
    @objc func finished(){
        guard let nombre = zoneTextField!.text, zoneTextField!.hasText else{
            print("Nombre invalido ")
            return
        }
        let tmp = ["name": nombre] as [String:Any]
        delegate?.addZone(zone: tmp)
        zoneTextField?.text = ""
    }
    
    @objc func canceled(){
        self.dismiss(animated: true, completion: nil)
    }
}




