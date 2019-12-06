//
//  SettingsController.swift
//  GranjApp
//
//  Created by Administrador on 26/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "SettingsCell"

class SettingsController : UIViewController {
    var tableView: UITableView!
    var userInfoHeader: UserInfoHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        load()
        loadTeams()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func configureTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        let frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 100)
        userInfoHeader = UserInfoHeader(frame: frame)
        tableView.tableHeaderView = userInfoHeader
        tableView.tableFooterView = UIView()
    }
    func load(){
        sharedUsersInstance.getByIdRequest(url: "http://granjapp2.appspot.com/users/", id: "\(usuario!.id)"){ (response,error) in
            if error == nil{
            DispatchQueue.main.async {
                usuario = response
                }
            }
        }
    }
    
    func loadTeams(){
        sharedTeamInstance.getRequest(url: "http://granjapp2.appspot.com/teams/"){(str,array,error) in
            if error == nil{
                DispatchQueue.main.async {
                    teams = array
                }
            }
        }
    }
    
      override func viewWillAppear(_ animated: Bool) {
               super.viewWillAppear(animated)
            configureUI()
        load()
               navigationController?.setNavigationBarHidden(true, animated: false)
           }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            configureUI()
            load()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
           
           override func viewWillDisappear(_ animated: Bool) {
               super.viewWillDisappear(animated)
               navigationController?.setNavigationBarHidden(false, animated: true)
           }
    
    
    func configureUI(){
        configureTableView()
        
        
    }
}


extension SettingsController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else {return 0}
        
        switch section{
        case .Social: return SocialOptions.allCases.count
        case .Communications: return CommunicationsOptions.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Earth")
        let title = UILabel()
        title.text = SettingsSection(rawValue: section)?.description
        
        title.textColor = .white
        title.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let section = SettingsSection(rawValue: indexPath.section)else{return }
        switch section{
        case .Social:
            guard let socialsection = SocialOptions(rawValue: indexPath.row )else{return}
            
            switch socialsection {
            case .editProfile:
                navigationController?.pushViewController(ProfileController.init(), animated: true)
            case .equipo:
                navigationController?.pushViewController(JoinTeam.init(), animated: true)
            case .logout:
                navigationController?.pushViewController(HomeViewController.init(), animated: true)
        }
            
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        guard let section = SettingsSection(rawValue: indexPath.section) else {return UITableViewCell()}
        switch section{
        case .Social:
            let social = SocialOptions(rawValue: indexPath.row)
            cell.sectionType = social
        case .Communications:
            let communications = CommunicationsOptions(rawValue: indexPath.row)
            cell.sectionType = communications
        }
        return cell
    }
    
    
}
