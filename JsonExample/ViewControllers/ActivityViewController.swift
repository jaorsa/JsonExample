//
//  ViewController.swift
//  JsonExample
//
//  Created by Administrador on 07/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ActivityCell"


class ActivityViewController: UIViewController {
    var activities: [Activities] = []
    
    
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
        sharedActivityInstance.getRequest(url: "http://localhost:10010/activities"){(str, array, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.activities = array
                    print(array)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func save(){
        saveButton.setTitleColor(UIColor.blue, for: .normal)
        let tmp = [ "name": "Alimentar perro", "fechaInicio": "2012-11-04" + "T14:51:06.157Z", "fechaTerminacion": "2017-11-04" + "T" + "14:51:06.157" + "Z", "descripcion": "rfsfsfsdfsd", "complejidad": 1, "usuario": 2, "calificacion": 4] as [String : Any]
            sharedActivityInstance.postRequest(url: "http://localhost:10010/activities", body: tmp)
    }
    
    
    @objc func deleteresource(){
        deleteButton.setTitleColor(UIColor.blue, for: .normal)
        sharedActivityInstance.deleteRequest(url: "http://localhost:10010/activities/", id: "12")
    }
    
    
    @objc func updateresource(){
        updateButton.setTitleColor(UIColor.blue, for: .normal)
        sharedActivityInstance.putRequest(url: "http://localhost:10010/activities/", id: "11", name: "Rellenar el agua", fechaInicio: "2012-11-04", terminado: 1, descripcion: "asdasdasd", complejidad: 1, usuario:
            2, calificacion: 4)
    }
}
extension ActivityViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = activities[indexPath.row].name
        return cell
    }
    
    
}


