
//
//  TabController.swift
//  GranjApp
//
//  Created by Administrador on 21/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

class TabController: UITabBarController{
    
    
    override func viewDidLoad() {
        let zero = AnimalViewController()
        zero.tabBarItem = UITabBarItem(title: "Animales", image: #imageLiteral(resourceName: "huella"), tag: 0)
        
        let first = ActivitiesController()
        first.tabBarItem = UITabBarItem(title: "Tareas", image: #imageLiteral(resourceName: "tarea"), tag: 1)
        let second = ZoneViewController()
        second.tabBarItem = UITabBarItem(title: "Cultivos", image: #imageLiteral(resourceName: "hoja"), tag: 2)
        let third = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScoreTableController") as! ScoreTableController
        third.tabBarItem = UITabBarItem(title: "Trabajo", image: #imageLiteral(resourceName: "user"), tag: 3)
        let fourth = SettingsController()
        fourth.tabBarItem = UITabBarItem(title: "Extras", image: #imageLiteral(resourceName: "menu"), tag: 4)
        
        let tabBarList = [zero, first, second, third, fourth]
        viewControllers = tabBarList
    }
}
