//
//  ViewController.swift
//  JsonExample
//
//  Created by Administrador on 07/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import UIKit

/*
private let reuseIdentifier = "ResourceCell"


class ResourceViewController: UIViewController {
    //var resources: [Resource] = []
    
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(ResourceCell.self, forCellReuseIdentifier: reuseIdentifier)
        table.rowHeight = 50
        
        return table
    }()
    
    let loadButton: UIButton = {
       let button = UIButton()
        button.setTitle("Load Resources", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //button.backgroundColor = UIColor.green
        return button
    }()
    
    let saveButton: UIButton = {
       let button = UIButton()
        button.setTitle("Save Todos", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //button.backgroundColor = UIColor.green
        return button
    }()
    
    let deleteButton: UIButton = {
       let button = UIButton()
        button.setTitle("Delete Todos", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //button.backgroundColor = UIColor.green
        return button
    }()
    
    let updateButton: UIButton = {
       let button = UIButton()
        button.setTitle("Update Value", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //button.backgroundColor = UIColor.green
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 5, paddingBottom: 20, paddingRight: 20)
        tableView.dataSource = self
        load()
    }

    @objc func load(){
        loadButton.setTitleColor(UIColor.blue, for: .normal)
        sharedResourceInstance.getRequest(url: "http://granjapp2.appspot.com/resources"){(str, array, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.resources = array
                    print(array)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func save(){
        saveButton.setTitleColor(UIColor.blue, for: .normal)
        let tmp = ["name": "betabel", "type": 19] as [String : Any]
            sharedResourceInstance.postRequest(url: "http://granjapp2.appspot.com/resources", body: tmp)
    }
    
    
    @objc func deleteresource(){
        deleteButton.setTitleColor(UIColor.blue, for: .normal)
        sharedResourceInstance.deleteRequest(url: "http://granjapp2.appspot.com/resources/", id: "5")
    }
    
    
    @objc func updateresource(){
        deleteButton.setTitleColor(UIColor.blue, for: .normal)
        sharedResourceInstance.putRequest(url: "http://granjapp2.appspot.com/resources/", id: "4", name: "tomate", type: 22)
    }
}
extension ResourceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = resources[indexPath.row].name
        return cell
    }
    
    
}*/


