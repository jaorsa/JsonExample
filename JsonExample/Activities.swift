import Foundation
import UIKit

struct Activities: Codable{
    var id: Int
    var name: String
    var fechaInicio: String
    var fechaTerminacion: String
    var descripcion: String?
    var complejidad: Int
    var usuario: Int?
    var calificacion: Int
    
    init(_ dictionary: [String: Any]) {
      self.id = dictionary["id"] as? Int ?? 0
      self.name = dictionary["name"] as? String ?? ""
        self.fechaInicio = dictionary["fechaInicio"] as? String ?? ""
        self.fechaTerminacion = dictionary["fechaTerminacion"] as? String ?? ""
        self.descripcion = dictionary["descripcion"] as? String ?? ""
        self.complejidad = dictionary["complejidad"] as? Int ?? 0
        self.usuario = dictionary["usuario"] as? Int ?? 0
        self.calificacion = dictionary["calificacion"] as? Int ?? 0
    }
}
