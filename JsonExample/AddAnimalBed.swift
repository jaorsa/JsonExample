//
//  AddActivityController.swift
//  GranjApp
//
//  Created by Administrador on 24/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

let hembrasTextField: UITextField? = {
    let texf = UITextField()
    texf.placeholder = "Cantidad de hembras"
    texf.textAlignment = .center
    texf.translatesAutoresizingMaskIntoConstraints = false
    return texf
}()

let nameTextField: UITextField? = {
    let texf = UITextField()
    texf.placeholder = "Especie de la camada"
    texf.textAlignment = .center
    texf.translatesAutoresizingMaskIntoConstraints = false
    return texf
}()


let machosTextField: UITextField? = {
   let textf = UITextField()
    textf.placeholder = "Cantidad de machos"
    textf.textAlignment = .center
    textf.translatesAutoresizingMaskIntoConstraints = false
    return textf
}()

let borndatePicker: UIDatePicker? = {
   let datep = UIDatePicker()
    datep.backgroundColor = UIColor.white
    datep.timeZone = NSTimeZone.local
    datep.datePickerMode = .date
    datep.minimumDate = Date()
    return datep
}()

let saludPicker: UIPickerView? = {
    let picker = UIPickerView()
    picker.backgroundColor = UIColor.white
    picker.tag = 1
    return picker
}()

let saludTextField: UITextField? = {
   let textf = UITextField()
   textf.placeholder = "Salud de la camada"
   textf.textAlignment = .center
    return textf
}()

let crecimientoPicker: UIPickerView? = {
    let picker = UIPickerView()
    picker.backgroundColor = UIColor.white
    picker.tag = 2
    return picker
}()

let crecimientoTextField: UITextField? = {
   let textf = UITextField()
   textf.placeholder = "Etapa de la camada"
   textf.textAlignment = .center
    return textf
}()


let borndateTextField: UITextField? = {
   let textf = UITextField()
   textf.placeholder = "Fecha de nacimiento"
   textf.textAlignment = .center
    return textf
}()


protocol AddAnimalBedDelegate {
    func addanimal(animal: [String:Any])
}

class AddAnimalBed: UIViewController{
    var delegate: AddAnimalBedDelegate?
    
    let saludArray = ["", "Saludable", "Enfermo"]
    let crecimientoArray = ["", "Nacimiento", "Crecimiento","Engorda"]
    var SelectedSalud: String?
    var selectedCrecimiento: String?
    var selectedsaludint: Int?
    var selectedcrecimientoint: Int?
    
    var selectedid: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(teamusers as Any)
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finished))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(canceled))
        
        view.addSubview(nameTextField!)
        
        nameTextField!.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, height: 40)
        nameTextField!.becomeFirstResponder()
        
        view.addSubview(borndateTextField!)
        //datePicker!.delegate = self
        borndateTextField!.anchor(top: nameTextField?.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, height: 40)
        //borndateTextField!.becomeFirstResponder()
        borndateTextField?.inputView = datePicker
        
        view.addSubview(hembrasTextField!)
        hembrasTextField!.anchor(top: borndateTextField?.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, height: 40)
        
        view.addSubview(machosTextField!)
               machosTextField!.anchor(top: hembrasTextField?.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, height: 40)
               
        
        view.addSubview(saludTextField!)
        saludPicker!.delegate = self
        saludTextField!.anchor(top: machosTextField!.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        saludTextField?.inputView = saludPicker
        
        view.addSubview(crecimientoTextField!)
        crecimientoPicker!.delegate = self
        crecimientoTextField!.anchor(top: saludTextField!.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        crecimientoTextField?.inputView = crecimientoPicker
        
        saludPicker?.selectRow(0, inComponent: 0, animated: false)
        saludTextField!.text = saludArray[0]
        
        crecimientoPicker?.selectRow(0, inComponent: 0, animated: false)
        crecimientoTextField!.text = crecimientoArray[0]
        
        
        borndatePicker?.setDate(Date(), animated: false)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        borndateTextField!.text = dateFormatter.string(from: borndatePicker!.date)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    /*
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
    */
    let tooldatebar: UIToolbar = {
       let tool = UIToolbar()
        tool.sizeToFit()
        let done = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(doneDate))
        tool.setItems([done], animated: false)
        tool.isUserInteractionEnabled = true
        borndateTextField?.inputAccessoryView = tool
        return tool
    }()
    
    @objc func finished(){
        
        guard let nombre = nameTextField!.text, nameTextField!.hasText else{
            nameTextField?.text = ""
            nameTextField?.placeholder = "Nombre invalido"
            return
        }
        guard let hembras = hembrasTextField?.text! , hembrasTextField!.hasText else{
            hembrasTextField?.text = ""
            hembrasTextField?.placeholder = "Porfavor ingrese una cantidad"
            return
        }
        guard let machos = machosTextField?.text! , machosTextField!.hasText else{
            machosTextField?.text = ""
            machosTextField?.placeholder = "Por favor ingrese una cantidad"
            return
        }
        
        guard let fecha = borndateTextField?.text! , borndateTextField!.hasText else{
            borndateTextField?.text = ""
            borndateTextField?.placeholder = "Fecha invalida"
            return
        }
        
        guard let salud = saludTextField?.text! , saludTextField!.hasText else{
            saludTextField?.text = ""
            saludTextField?.placeholder = "Entrada invalida"
            return
        }
        
        guard let etapa = crecimientoTextField?.text! , crecimientoTextField!.hasText else{
            crecimientoTextField?.text = ""
            crecimientoTextField?.placeholder = "Entrada invalida"
            return
        }
        
        var nhembras = Int(hembras)
        var nmachos = Int(machos)
        
        if nhembras != nil{
            if nmachos != nil{
                let tmp = ["name": nombre, "fechaNacimiento": fecha, "equipo": teamid!, "no_h": nhembras!, "no_m": nmachos!, "salud": selectedsaludint, "especie": 1,"etapa":selectedcrecimientoint] as [String:Any]
                
                    delegate?.addanimal(animal: tmp)
                
                    nameTextField?.text! = ""
                    hembrasTextField?.text! = ""
                machosTextField?.text! = ""
                
                    saludPicker?.selectRow(0, inComponent: 0, animated: false)
                    saludTextField!.text = saludArray[0]
                    //userPicker?.selectedRow(inComponen)
                    crecimientoPicker?.selectRow(0, inComponent: 0, animated: false)
                    crecimientoTextField!.text = crecimientoArray[0]
                
                    borndatePicker?.setDate(Date(), animated: false)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    borndateTextField!.text = dateFormatter.string(from: borndatePicker!.date)
            }else{
                machosTextField?.text = ""
                machosTextField?.placeholder = "Entrada invalida"
                return
            }
        }else{
            hembrasTextField?.text = ""
            hembrasTextField?.placeholder = "Entrada invalida"
            return
        }
        
        
        
    }
    
    @objc func canceled(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hideKeyboard(){
        print("teclado escondido")
        view.endEditing(true)
    }
    
    /*
    @objc func doneComplexity(){
        
        complexityTextField!.text = SelectedComplexity
        view.endEditing(true)
    }
    
    @objc func doneUser(){
        userTextField!.text = selectedUser
        view.endEditing(true)
    }*/
    
    @objc func doneDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        borndateTextField!.text = dateFormatter.string(from: datePicker!.date)
        view.endEditing(true)
    }
}

extension AddAnimalBed: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{return saludArray.count}
        else {return crecimientoArray.count}
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return saludArray[row]
        }
        else {
            return crecimientoArray[row]
        }
        //return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if saludPicker! == pickerView{
        SelectedSalud = saludArray[row]
            selectedsaludint = row
            saludTextField?.text = SelectedSalud
            view.endEditing(true)
        }
        else if pickerView == crecimientoPicker!{
            selectedCrecimiento = crecimientoArray[row]
            selectedcrecimientoint = row
            crecimientoTextField?.text = selectedCrecimiento
            view.endEditing(true)
        }
    }
    
}




