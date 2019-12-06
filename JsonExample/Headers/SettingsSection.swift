//
//  SettingsSection.swift
//  GranjApp
//
//  Created by Administrador on 26/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

protocol SectionType: CustomStringConvertible{
    var containsSwitch: Bool {get}
}


enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case Social
    case Communications
    
    
    var description: String{
        switch self {
        case .Social: return "Social"
        case .Communications: return "Comunicación"
        }
    }
}

enum SocialOptions: Int, CaseIterable, SectionType{
    case editProfile
    case equipo
    case logout
     var containsSwitch: Bool {return false}
    
    var description: String{
        switch self {
        case .editProfile: return "Editar Perfil"
        case .equipo: return "Ingresar a un equipo"
        case .logout: return "Cerrar Sesión"
        }
    }
    
}


enum CommunicationsOptions: Int, CaseIterable, SectionType{
    case notifications
    
    var containsSwitch: Bool {
        switch self{
        case .notifications: return true
        }
    }
    
    var description: String{
        switch self {
        case .notifications: return "Notificaciones"
        }
    }
    
}

