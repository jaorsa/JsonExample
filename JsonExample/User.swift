//
//  Planting.swift
//
//
//  Created by Administrador on 19/11/19.
//

import Foundation

struct User: Codable{
    var id: Int
    var name: String
    var correo: String
    
    init(_ dictionary: [String: Any]) {
      self.id = dictionary["id"] as? Int ?? 0
        self.name = dictionary["name"] as? String ?? ""
        self.correo = dictionary["correo"] as? String ?? ""
    }
}
