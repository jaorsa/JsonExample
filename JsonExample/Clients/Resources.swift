//
//  Resource.swift
//  JsonExample
//
//  Created by Administrador on 17/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
struct Resource: Codable{
    var id: Int
    var name: String
    var type: Int?
    
    init(_ dictionary: [String: Any]) {
      self.id = dictionary["id"] as? Int ?? 0
      self.name = dictionary["name"] as? String ?? ""
        self.type = dictionary["type"] as? Int ?? 0
    }
}
