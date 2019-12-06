//
//  SettingsCell.swift
//  GranjApp
//
//  Created by Administrador on 26/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

class SettingsCell: UITableViewCell{
    
    var sectionType: SectionType?{
        didSet{
            guard let sectionType = sectionType else {return}
            textLabel?.text = sectionType.description
            switchControl.isHidden = !sectionType.containsSwitch
        }
    }
    
    
    lazy var switchControl: UISwitch = {
       let button = UISwitch()
        button.isOn = true
        button.onTintColor = UIColor(named: "Lime")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //backgroundColor = UIColor(named: "Lime")
        addSubview(switchControl)
        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleSwitchAction(sender: UISwitch){
        if sender.isOn{
            print("isOn")
            //sender.setOn(false, animated: true)
        }else{
            
        }
    }
}
