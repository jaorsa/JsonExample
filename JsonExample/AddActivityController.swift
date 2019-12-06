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
    picker.tag = 1
    return picker
}()

let complexityTextField: UITextField? = {
   let textf = UITextField()
   textf.placeholder = "Complejidad de la actividad"
   textf.textAlignment = .center
    return textf
}()

let userPicker: UIPickerView? = {
    let picker = UIPickerView()
    picker.backgroundColor = UIColor.white
    picker.tag = 2
    return picker
}()

let userTextField: UITextField? = {
   let textf = UITextField()
   textf.placeholder = "Usuario asignado"
   textf.textAlignment = .center
    return textf
}()



let dateTextField: UITextField? = {
   let textf = UITextField()
   textf.placeholder = "Fecha de la actividad"
   textf.textAlignment = .center
    return textf
}()



protocol AddActivitiesDelegate {
    func addActivity(activity: [String:Any])
}

class AddActivityController: UIViewController{
    var delegate: AddActivitiesDelegate?
    
    let numbers = ["1", "2", "3", "4", "5"]
    var SelectedComplexity: String?
    var selectedUser: String?
    var selectedid: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(teamusers as Any)
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finished))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(canceled))
        view.addSubview(activityTextField!)
        activityTextField!.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, height: 40)
        activityTextField!.becomeFirstResponder()
        view.addSubview(descriptionTextField!)
        descriptionTextField!.anchor(top: activityTextField?.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, height: 40)
        
        
        view.addSubview(complexityTextField!)
        complexityPicker!.delegate = self
        complexityTextField!.anchor(top: descriptionTextField!.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        complexityTextField?.inputView = complexityPicker
        
        view.addSubview(userTextField!)
        userPicker!.delegate = self
        userTextField!.anchor(top: complexityTextField!.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        userTextField?.inputView = userPicker
        
        view.addSubview(dateTextField!)
        dateTextField!.anchor(top: userTextField!.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        //datePicker?.addTarget(self, action: #selector(doneDate), for: .valueChanged)
        dateTextField?.inputView = datePicker
        
        complexityPicker?.selectRow(0, inComponent: 0, animated: false)
        complexityTextField!.text = numbers[0]
        datePicker?.setDate(Date(), animated: false)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateTextField!.text = dateFormatter.string(from: datePicker!.date)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
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
    
    let tooluserbar: UIToolbar = {
       let tool = UIToolbar()
        tool.sizeToFit()
        let done = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(doneUser))
        tool.setItems([done], animated: false)
        tool.isUserInteractionEnabled = true
        userTextField?.inputAccessoryView = tool
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
            activityTextField!.text = ""
            activityTextField!.placeholder = "Nombre invalido"
            return
        }
        guard let complex = complexityTextField?.text! , complexityTextField!.hasText else{
            complexityTextField?.text! = ""
            complexityTextField?.placeholder = "Complejidad invalida"
            print("Complejidad invalida ")
            return
        }
        guard let user = userTextField?.text! , userTextField!.hasText else{
            print("Usuario invalido ")
            return
        }
        
        guard let fecha = dateTextField?.text! , dateTextField!.hasText else{
            print("Fecha invalida ")
            return
        }
        let complejidad = Int(complex)
        comp = complejidad ?? 0
        
        
        let tmp = ["name": nombre, "fechaInicio": fecha, "terminado": 1, "descripcion": descripcion!, "complejidad": complejidad, "usuario": selectedid, "calificacion": 0, "equipo": teamid] as [String : Any]
            print("Todo bonito, todo hermoso")
            print(tmp)
            delegate?.addActivity(activity: tmp)
            activityTextField?.text! = ""
            descriptionTextField?.text! = ""
            complexityPicker?.selectRow(0, inComponent: 0, animated: false)
            complexityTextField!.text = ""//numbers[0]
            //userPicker?.selectedRow(inComponen)
        userTextField?.text = teamusers?[0].name
            datePicker?.setDate(Date(), animated: false)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateTextField!.text = dateFormatter.string(from: datePicker!.date)
    }
    
    @objc func canceled(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func doneComplexity(){
        
        complexityTextField!.text = SelectedComplexity
        view.endEditing(true)
    }
    
    @objc func doneUser(){
        userTextField!.text = selectedUser
        view.endEditing(true)
    }
    
    @objc func hideKeyboard(){
        print("teclado escondido")
        view.endEditing(true)
    }
    
    @objc func doneDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateTextField!.text = dateFormatter.string(from: datePicker!.date)
        view.endEditing(true)
    }
}

extension AddActivityController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{return numbers.count}
        else {return teamusers!.count}
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return numbers[row]
        }
        else {
            return teamusers?[row].name
        }
        //return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if complexityPicker! == pickerView{
        SelectedComplexity = numbers[row]
            view.endEditing(false)
        }
        else if pickerView == userPicker!{
            
            selectedUser = teamusers?[row].name
            selectedid = teamusers?[row].id
            view.endEditing(false)
        }
    }
    
}




