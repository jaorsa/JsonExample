//
//  ViewController.swift
//  JsonExample
//
//  Created by Administrador on 07/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TeamCell"


class TeamViewController: UIViewController {
    var teams: [Teams] = []
    
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(TeamCell.self, forCellReuseIdentifier: reuseIdentifier)
        table.rowHeight = 50
        
        return table
    }()
    
    let loadButton: UIButton = {
       let button = UIButton()
        button.setTitle("Load Teams", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //button.backgroundColor = UIColor.green
        return button
    }()
    
    let saveButton: UIButton = {
       let button = UIButton()
        button.setTitle("Save Teams", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //button.backgroundColor = UIColor.green
        return button
    }()
    
    let deleteButton: UIButton = {
       let button = UIButton()
        button.setTitle("Delete Teams", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //button.backgroundColor = UIColor.green
        return button
    }()
    
    let updateButton: UIButton = {
       let button = UIButton()
        button.setTitle("Update Team", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //button.backgroundColor = UIColor.green
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 5, paddingBottom: 0, paddingRight: 20, height: 500)
        tableView.dataSource = self
        
        view.addSubview(loadButton)
        loadButton.anchor(top: tableView.bottomAnchor, bottom: nil, paddingTop: 50, paddingBottom: 0, width: 200, height: 50)
        
        loadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadButton.addTarget(self, action: #selector(load), for: .touchUpInside)
        
        
        view.addSubview(saveButton)
        saveButton.anchor(top: loadButton.bottomAnchor, bottom: nil, paddingTop: 10, paddingBottom: 0, width: 200, height: 50)
        
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        
        view.addSubview(deleteButton)
        deleteButton.anchor(top: saveButton.bottomAnchor, bottom: nil, paddingTop: 10, paddingBottom: 0, width: 200, height: 50)
        
        deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deleteButton.addTarget(self, action: #selector(deleteresource), for: .touchUpInside)
        
        
        view.addSubview(updateButton)
        updateButton.anchor(top: deleteButton.bottomAnchor, bottom: nil, paddingTop: 10, paddingBottom: 0, width: 200, height: 50)
        
        updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        updateButton.addTarget(self, action: #selector(updateresource), for: .touchUpInside)
    }

    @objc func load(){
        loadButton.setTitleColor(UIColor.blue, for: .normal)
        sharedTeamInstance.getRequest(url: "http://ranjapp2.appspot.com/teams"){(str, array, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.teams = array
                    print(array)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func save(){
        saveButton.setTitleColor(UIColor.blue, for: .normal)
        let tmp = ["name": "Kick", "description":""] as [String : Any]
            sharedTeamInstance.postRequest(url: "http://localhost:10010/teams", body: tmp)
    }
    
    
    @objc func deleteresource(){
        deleteButton.setTitleColor(UIColor.blue, for: .normal)
        sharedTeamInstance.deleteRequest(url: "http://localhost:10010/teams/", id: "3")
    }
    
    
    @objc func updateresource(){
        updateButton.setTitleColor(UIColor.blue, for: .normal)
        sharedTeamInstance.putRequest(url: "http://localhost:10010/teams/", id: "3", name: "Woodies", description: "Equipo")
    }
}
extension TeamViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = teams[indexPath.row].name
        return cell
    }
    
    
}


