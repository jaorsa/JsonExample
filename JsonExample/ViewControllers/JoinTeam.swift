//
//  JoinTeam.swift
//  JsonExample
//
//  Created by Administrador on 06/12/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "UserCell"

class JoinTeam: UIViewController{
    //var searchBar:
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        table.rowHeight = 60
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        view.backgroundColor = UIColor(named: "ForestGreen")
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
    }
    
    func load(){
        sharedTeamInstance.getRequest(url: "http://granjapp2.appspot.com/teams/"){(str,array,error) in
            if error == nil{
                DispatchQueue.main.async {
                    teams = array
                }
            }
        }
    }
    
}
extension JoinTeam: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.team = teams?[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    
}
extension JoinTeam: UserCellDelegate{
    func joinTeam(cell: UserCell) {
        
        let tmp = ["user":usuario?.id, "team":cell.team?.id] as [String:Any]
        sharedTeamInstance.postRol(url: "http://granjapp2.appspot.com/roles", body: tmp){
            (success) in
            if success == true{
                teamid = cell.team?.id
                
            }
            //cell.JoinButton.setTitle("Eres miembro", for: .normal)
            //cell.JoinButton.setTitleColor(UIColor(named: "Lime"), for: .normal)
            //cell.JoinButton.backgroundColor = .white
        }
    }
    
    
}
