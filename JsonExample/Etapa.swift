import Foundation

struct Etapa: Codable{
    var id: Int
    var name: String
    
    init(_ dictionary: [String: Any]) {
      self.id = dictionary["id"] as? Int ?? 0
      self.name = dictionary["name"] as? String ?? ""
    }
}
