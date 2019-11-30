//
//  Teams.swift
//  JsonExample
//
//  Created by Administrador on 27/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
struct Teams: Decodable{
    var id: Int
    var name: String
    var description: String
    var zones: [zone]?
    var usuarios: [Usuarios]?
    var animals: [Animal]?
    var actividades: [Activities]?
}

struct Usuarios: Decodable{
    var id: Int
    var name: String?
    var lastname: String?
    var correo: String?
    var estrellas: Int?
    var admin: Int?
    var Roles: Roles?
}

struct subzone: Decodable{
    var id: Int
    var name: String?
    var zone: Int?
}

struct zone: Decodable{
    var id: Int
    var name: String
    var team: Int
}

struct Zone: Decodable{
    var id: Int
    var name: String
    var team: Int
    var subzones: [subzone]?
}

struct Subzone: Decodable{
    var id: Int
    var name: String
    var zone: Int
    var plantings: [planting]?
}

struct planting: Decodable{
    var id: Int
    var salud: Int
    var cultivo: Int
    var subzona: Int
}

struct Planting: Decodable{
    var id: Int
    var salud: Int
    var cultivo: Int
    var subzona: Int
    var aplicaciones: [Applications]?
}

struct Applications: Decodable{
    var id: Int
    var siembra: Int
    var recurso:Int
    var fecha: String
}

struct Animal: Decodable{
    var id: Int
    var name: String
    var fechaNacimiento: String?
    var equipo: Int?
    var no_h: Int?
    var no_m: Int?
    var salud: Int?
    var especie: Int?
    var etapa: Int?
}
