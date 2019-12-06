//
//  Users.swift
//  JsonExample
//
//  Created by Administrador on 26/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
struct Users: Decodable{
    var id: Int
    var name: String?
    var lastname: String?
    var correo: String?
    var estrellas: Int?
    var admin: Int?
    var password: String?
    var activities: [Activities]?
    var equipos: [Equipos]?
}

struct Equipos: Decodable{
    var id: Int
    var name: String?
    var description: String?
    var Roles: Roles?
}

struct Activities: Decodable{
var id: Int
var name: String?
var fechaInicio: String?
var terminado: Int?
var descripcion: String?
var complejidad: Int?
var usuario: Int?
var calificacion: Int?
var equipo: Int?
}

struct Roles: Decodable{
    var user: Int?
    var team: Int?
}

struct Token: Decodable{
    var token: String
}
