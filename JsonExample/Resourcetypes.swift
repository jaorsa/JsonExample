//
//  Resourcetypes.swift
//  JsonExample
//
//  Created by Administrador on 15/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation

struct Resourcetypes: Codable{
    var id: Int
    var name: String
    
    init(_ dictionary: [String: Any]) {
      self.id = dictionary["id"] as? Int ?? 0
      self.name = dictionary["name"] as? String ?? ""
    }
}

