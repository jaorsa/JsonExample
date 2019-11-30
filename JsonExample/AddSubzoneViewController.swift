//
//  AddZoneController.swift
//  GranjApp
//
//  Created by Administrador on 24/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

let subzoneTextField: UITextField? = {
    let texf = UITextField()
    texf.placeholder = "Nombre de la zona"
    texf.textAlignment = .center
    texf.translatesAutoresizingMaskIntoConstraints = false
    return texf
}()



protocol AddSubzoneDelegate{
    func addSubzone(name:String)
}

class AddASubzoneViewController: UIViewController{
    var delegate: AddSubzoneDelegate?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finished))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(canceled))
        view.addSubview(subzoneTextField!)
        subzoneTextField!.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, height: 40)
        subzoneTextField!.becomeFirstResponder()
    }
    
    
    @objc func finished(){
        guard let nombre = subzoneTextField!.text, subzoneTextField!.hasText else{
            print("Nombre invalido ")
            return
        }
        delegate?.addSubzone(name: nombre)
        subzoneTextField?.text = ""
    }
    
    @objc func canceled(){
        self.dismiss(animated: true, completion: nil)
    }
}




