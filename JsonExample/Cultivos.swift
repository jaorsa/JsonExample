//
//  Team.swift
//
//
//  Created by Administrador on 18/11/19.
//

import Foundation

struct Cultivos: Codable{
    var id: Int
    var name: String
    var startDate: String
    var endDate: String
    var cropType: Int?
    
    
    init(_ dictionary: [String: Any]) {
      self.id = dictionary["id"] as? Int ?? 0
      self.name = dictionary["name"] as? String ?? ""
        self.startDate = dictionary["startDate"] as? String ?? ""
        self.endDate = dictionary["endDate"] as? String ?? ""
        self.cropType = dictionary["cropType"] as? Int ?? 0
    }
}
