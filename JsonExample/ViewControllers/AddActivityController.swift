//
//  AddActivityController.swift
//  GranjApp
//
//  Created by Administrador on 24/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

let activityTextField: UITextField? = {
    let texf = UITextField()
    texf.placeholder = "Nombre de la actividad"
    texf.textAlignment = .center
    texf.translatesAutoresizingMaskIntoConstraints = false
    return texf
}()

let descriptionTextField: UITextField? = {
   let textf = UITextField()
    textf.placeholder = "Descripción de la actividad"
    textf.textAlignment = .center
    textf.translatesAutoresizingMaskIntoConstraints = false
    return textf
}()

let datePicker: UIDatePicker? = {
   let datep = UIDatePicker()
    datep.backgroundColor = UIColor.white
    datep.timeZone = NSTimeZone.local
    datep.datePickerMode = .date
    datep.minimumDate = Date()
    return datep
}()

let complexityPicker: UIPickerView? = {
    let picker = UIPickerView()
    picker.backgroundColor = UIColor.white
    return picker
}()

let complexityTextField: UITextField? = {
   let textf = UITextField()
   textf.placeholder = "Complejidad de la actividad"
   textf.textAlignment = .center
    return textf
}()

let dateTextField: UITextField? = {
   let textf = UITextField()
   textf.placeholder = "Fecha de la actividad"
   textf.textAlignment = .center
    return textf
}()



protocol AddActivityDelegate {
    func addActivity(activity: Activity)
}

class AddActivityController: UIViewController{
    var delegate: AddActivityDelegate?
    
    let numbers = ["1", "2", "3", "4", "5"]
    var SelectedComplexity: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finished))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(canceled))
        view.addSubview(activityTextField!)
        //activityTextField!.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //activityTextField!.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //activityTextField!.widthAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        activityTextField!.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, height: 40)
        activityTextField!.becomeFirstResponder()
        view.addSubview(descriptionTextField!)
        descriptionTextField!.anchor(top: activityTextField?.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, height: 40)
        view.addSubview(complexityTextField!)
        complexityPicker!.delegate = self
        complexityTextField!.anchor(top: descriptionTextField!.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        complexityTextField?.inputView = complexityPicker
        
        view.addSubview(dateTextField!)
        dateTextField!.anchor(top: complexityTextField!.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        //datePicker?.addTarget(self, action: #selector(doneDate), for: .valueChanged)
        dateTextField?.inputView = datePicker
        
    }
    
    let toolbar: UIToolbar = {
       let tool = UIToolbar()
        tool.sizeToFit()
        let done = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(doneComplexity))
        tool.setItems([done], animated: false)
        tool.isUserInteractionEnabled = true
        complexityTextField?.inputAccessoryView = tool
        return tool
    }()
    
    let tooldatebar: UIToolbar = {
       let tool = UIToolbar()
        tool.sizeToFit()
        let done = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(doneDate))
        tool.setItems([done], animated: false)
        tool.isUserInteractionEnabled = true
        dateTextField?.inputAccessoryView = tool
        return tool
    }()
    
    @objc func finished(){
        var comp: Int = 0
        //let nombre = activityTextField?.text!
        let descripcion = descriptionTextField?.text!
        //let complejidad = Int((complexityTextField?.text!)!)
        //comp = complejidad ?? 0
        
        //print(complexityTextField?.text! ?? 0)
        guard let nombre = activityTextField!.text, activityTextField!.hasText else{
            print("Nombre invalido ")
            return
        }
        guard let complex = complexityTextField?.text! , complexityTextField!.hasText else{
            print("Complejidad invalida ")
            return
        }
        guard let fecha = dateTextField?.text! , dateTextField!.hasText else{
            print("Fecha invalida ")
            return
        }
        let complejidad = Int(complex)
        comp = complejidad ?? 0
        
        let tmp = Activity(title: nombre, description: descripcion!, complexity: comp, date: datePicker!.date, button: UIButton(), terminada: false, calificacion: 0)
            print("Todo bonito, todo hermoso")
            print(tmp.title)
            delegate?.addActivity(activity: tmp)
        print(comp)
        print(fecha)
        print(datePicker?.date)
        complexityTextField!.text = ""
        activityTextField?.text! = ""
        descriptionTextField?.text! = ""
        dateTextField?.text = ""
    }
    
    @objc func canceled(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func doneComplexity(){
        
        complexityTextField!.text = SelectedComplexity
        view.endEditing(true)
    }
    @objc func doneDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM - dd - yyyy"
        dateTextField!.text = dateFormatter.string(from: datePicker!.date)
        view.endEditing(true)
    }
}

extension AddActivityController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numbers[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SelectedComplexity = numbers[row]
    }
    
}


extension UITextField{
    func isActivityValid(activityname: String) -> Bool{
        //let activityNameRegEx = "[A-Z0-9a-z._%+-]{1,50}"
        let activityNameRegEx = "[A-Z0-9a-z._%+-] {1,50}"
        let activityTest = NSPredicate(format: "SELF MATCHES %@", activityNameRegEx)
        return activityTest.evaluate(with: activityname)
    }
}


