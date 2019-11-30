//
//  UserInfoHeader.swift
//  GranjApp
//
//  Created by Administrador on 26/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

var teams: [Teams]?

class TeamInfoHeader: UIView{
    
    let TeamButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 3
        button.contentMode = .scaleAspectFill
        //image.contentMode = .scaleAspectFill
        button.setImage(#imageLiteral(resourceName: "user"), for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 45/2
        return button
    }()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
            backgroundColor = UIColor(named: "ForestGreen")
           addSubview(TeamButton)
        TeamButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 45,height: 45)
        TeamButton.addTarget(self, action: #selector(load), for: .touchUpInside)
        load()
    }
    
    @objc func load(){
        print("button pressed")
        /*
        if roles?.isEmpty == false{
            for i in 0...roles!.count-1{
            sharedTeamInstance.getByIdRequest(url: "http://granjapp2.appspot.com/teams/", id: "\(roles![i].team )") {(userteam, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        teams?.append(userteam)
                        
                        }
                    }
                }
            }
            print(teams)
        }*/ 
    }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
    
}
