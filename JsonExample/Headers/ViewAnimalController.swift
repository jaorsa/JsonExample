//
//  ViewAnimalController.swift
//  JsonExample
//
//  Created by Administrador on 29/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

var container: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(named: "Grass")
    view.layer.cornerRadius = 5
    
    view.addSubview(fechaLabel)
    fechaLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 170, height: 15)
    view.addSubview(fecha)
    fecha.anchor(top: view.topAnchor, left: fechaLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 8, height: 15)
    
    view.addSubview(hembrasLabel)
    hembrasLabel.anchor(top: fechaLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 150, height: 15)
    view.addSubview(hembras)
    hembras.anchor(top: fechaLabel.bottomAnchor, left: hembrasLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 60, paddingBottom: 0, paddingRight: 8, height: 15)
    
    view.addSubview(machosLabel)
    machosLabel.anchor(top: hembrasLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 150, height: 15)
    view.addSubview(machos)
    machos.anchor(top: hembrasLabel.bottomAnchor, left: machosLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 60, paddingBottom: 0, paddingRight: 8, height: 15)
    
    view.addSubview(saludLabel)
    saludLabel.anchor(top: machosLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 150, height: 15)
    view.addSubview(salud)
    //healthPicker.delegate = self
    salud.anchor(top: machosLabel.bottomAnchor, left: saludLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 60, paddingBottom: 0, paddingRight: 8, height: 15)
    
    
    view.addSubview(etapaLabel)
    
    etapaLabel.anchor(top: saludLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 170, height: 15)
    view.addSubview(etapa)
    //etapaPicker.delegate = ViewAnimalController
    
    etapa.anchor(top: saludLabel.bottomAnchor, left: saludLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 60, paddingBottom: 0, paddingRight: 8, height: 15)
    
    
    
    return view
}()

let camadaLabel: UITextField = {
   let label = UITextField()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 25)
    label.text = "Camada X"
    label.textColor = UIColor(named: "ForestGreen")
    return label
}()

let fecha: UITextField = {
    let label = UITextField()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.text = ""
    label.textColor = UIColor(named: "Lime")
    return label
}()

let fechaLabel: UILabel = {
   let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.text = "Fecha de Nacimiento: "
    label.textColor = .white
    return label
}()

let healthPicker: UIPickerView = {
    let picker = UIPickerView()
    picker.backgroundColor = UIColor.white
    picker.tag = 1
    return picker
}()

let etapaPicker: UIPickerView = {
    let picker = UIPickerView()
    picker.backgroundColor = UIColor.white
    picker.tag = 2
    return picker
}()

let hembras: UITextField = {
    let label = UITextField()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.text = ""
    label.textColor = UIColor(named: "Lime")
    return label
}()

let hembrasLabel: UILabel = {
   let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.text = "Hembras: "
    label.textColor = .white
    return label
}()

let machosLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.text = "Machos: "
    label.textColor = .white
    return label
}()

let machos: UITextField = {
    let label = UITextField()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.text = ""
    label.textColor = UIColor(named: "Lime")
    return label
}()

let saludLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.textColor = .white
    label.text = "Estado de Salud: "
    return label
}()

let salud: UITextField = {
    let label = UITextField()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    //label.text = ""
    label.textColor = UIColor(named: "Lime")
    return label
}()

let etapaLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    label.textColor = .white
    label.text = "Etapa de crecimiento:"
    return label
}()

 let etapa: UITextField = {
     let label = UITextField()
     label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
     //label.text = ""
     label.textColor = UIColor(named: "Lime")
     return label
 }()

class ViewAnimalController: UIViewController{
    
    let estadosalud = ["", "Saludable", "Enfermo"]
    let etapacrecimiento = ["", "Nacimiento", "Crecimiento", "Engorda"]
    var SelectedSalud: String?
    var selectedCrecimiento: String?
    var selectedsaludint = 0
    var selectedcrecimientoint = 0
    var animal: Animal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialValues()
        view.backgroundColor = .white
        view.addSubview(camadaLabel)
        camadaLabel.anchor(top: view.topAnchor,paddingTop: 60, height: 50)
        camadaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(container)
        container.anchor(top: camadaLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 30, paddingBottom: 50, paddingRight: 30, height: 250)
        
        etapaPicker.delegate = self
        etapa.inputView = etapaPicker
        healthPicker.delegate = self
        salud.inputView = healthPicker
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finished))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    func setInitialValues(){
        camadaLabel.text = animal?.name
        fecha.text = animal?.fechaNacimiento
        hembras.text = "\(animal!.no_h!)"
        machos.text = "\(animal!.no_m!)"
        salud.text = estadosalud[(animal?.salud!)!]
        etapa.text = etapacrecimiento[(animal?.etapa)!]
    }
    
    @objc func hideKeyboard(){
        print("teclado escondido")
        view.endEditing(true)
    }
    
    @objc func finished(){
        
        guard let nombre = camadaLabel.text, camadaLabel.hasText else{
            camadaLabel.text = ""
            camadaLabel.placeholder = "Nombre invalido"
            return
        }
        guard let hembrastext = hembras.text, hembras.hasText else{
            hembras.text = ""
            hembras.placeholder = "Porfavor ingrese una cantidad"
            return
        }
        guard let machostxt = machos.text, machos.hasText else{
            machos.text = ""
            machos.placeholder = "Por favor ingrese una cantidad"
            return
        }
        
        guard let saludtxt = salud.text, salud.hasText else{
            salud.text = ""
            salud.placeholder = "Entrada invalida"
            return
        }
        
        guard let etapatxt = etapa.text, etapa.hasText else{
            etapa.text = ""
            etapa.placeholder = "Entrada invalida"
            return
        }
        
        let nhembras = Int(hembrastext)
        let nmachos = Int(machostxt)
        
        if nhembras != nil{
            if nmachos != nil{
                if selectedsaludint == 0{
                    selectedsaludint = animal!.salud!
                }
                    if selectedcrecimientoint == 0{
                        selectedcrecimientoint = animal!.etapa!
                    }
                let tmp = ["id": animal!.id, "name": nombre, "fechaNacimiento": animal!.fechaNacimiento!, "equipo": teamid!, "no_h": nhembras!, "no_m": nmachos!, "salud": selectedsaludint, "especie": 1,"etapa":selectedcrecimientoint] as [String:Any]
                    print(tmp)
                sharedAnimalInstance.putRequest(url: "http://granjapp2.appspot.com/animal/", id: "\(animal!.id)", body: tmp)
                
                let alert = UIAlertController(title: "Camada modificada", message: "Se ha modificado " + animal!.name + " con éxito", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
                    let controller = TabController()
                    self.navigationController?.pushViewController(controller, animated: true)
                    self.navigationController?.navigationBar.isHidden = true
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }else{
                machos.text = ""
                machos.placeholder = "Entrada invalida"
                return
            }
        }else{
            hembras.text = ""
            hembras.placeholder = "Entrada invalida"
            return
        }
        
        
        
    }
}
extension ViewAnimalController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{return estadosalud.count}
        else {return etapacrecimiento.count}
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return estadosalud[row]
        }
        else {
            return etapacrecimiento[row]
        }
        //return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if healthPicker == pickerView{
        SelectedSalud = estadosalud[row]
            selectedsaludint = row
            salud.text = SelectedSalud
            view.endEditing(true)
        }
        else if pickerView == etapaPicker{
            selectedCrecimiento = etapacrecimiento[row]
            selectedcrecimientoint = row
            etapa.text = selectedCrecimiento
            view.endEditing(true)
        }
    }
    
}

