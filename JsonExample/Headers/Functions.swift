//
//  Functions.swift
//  GranjApp
//
//  Created by Administrador on 18/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation

extension String{
    public func testActivityFormat(name: String, descripcion: String, complejidad: Int, fecha: String) -> Bool{
        
        if name.isEmpty{return false}
        
        if name.count < 51{}
        else{return false}
        
        if descripcion.count < 255 {}
        else {return false}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let tmp = dateFormatter.string(from: Date())
        if dateFormatter.date(from: tmp) != nil {}
        else {return false}
        
        if complejidad > 0 && complejidad < 6{return true}
        else{return false}
        
        
    }
    
    func testTeamFormat(name: String, users: Array<Int>) -> Bool{
        if name.isEmpty{return false}
        
        if name.count < 31 {}
        else{return false}
        
        if users.count > 0 && users.count < 16 {return true}
        else{return false}
    }
    
    func testZone(name: String) -> Bool{
        if name.isEmpty{return false}
        if name.count < 51 {return true}
        else{return false}
    }
    
    func testSubzone(name: String) -> Bool{
        if name.isEmpty{return false}
        if name.count < 31 {return true}
        else{return false}
    }
    
    func testEtapa(name: String) -> Bool{
        if name.isEmpty{return false}
        if name.count < 21 {return true}
        else{return false}
    }
    
    func testEspecie(name: String) -> Bool{
        if name.isEmpty{return false}
        if name.count < 31 {return true}
        else{return false}
    }
    
    func testTipoCultivo(name: String) -> Bool{
        if name.isEmpty{return false}
        if name.count < 31 {return true}
        else{return false}
    }
    
    func testUserFormat(name: String, correo: String) -> Bool{
        let fal = false
        
        if name.isEmpty{return false}
        let userNameRegEx = "[A-Z]|[a-z]{1,30}"
        let userTest = NSPredicate(format: "SELF MATCHES %@", userNameRegEx)
        let result = userTest.evaluate(with: name)
        if result == fal{return false}
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: correo)
        
        
    }
    
    func testResourceFormat(name: String, type: Int) -> Bool{
        if name.isEmpty{return false}
        
        if name.count < 51 {return true}
        else{return false}
    }
    
    func testAnimalBedFormat(fecha: String, especie: String, etapa: String, machos: Int, hembras: Int, salud: String) -> Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        if dateFormatter.date(from: fecha) != nil{}
        else {return false}
        
        if especie.count > 0 && especie.count < 31 {}
        else{return false}
        
        if etapa.count > 0 && etapa.count < 21{}
        else{return false}
        
        if machos > -1 && machos < 201 {}
        else{return false}
        
        if hembras > -1 && hembras < 201{}
        else{return false}
        
        if salud.count > 0 && salud.count < 31 {return true}
        else{return false}
        
    }
}
