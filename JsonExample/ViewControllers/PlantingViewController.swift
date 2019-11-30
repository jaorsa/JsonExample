//
//  ViewController.swift
//  JsonExample
//
//  Created by Administrador on 07/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PlantingCell"

var actualsubzone: Subzone?
var plants: [planting]?
class PlantingViewController: UIViewController {
    //var siembras: [Planting] = []
    
    
    let addButton: UIButton = {
       let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.setTitleColor(.white, for: .highlighted)
        return button
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(PlantingCell.self, forCellReuseIdentifier: reuseIdentifier)
        table.rowHeight = 50
        
        return table
    }()
    
    let saveButton: UIButton = {
       let button = UIButton()
        button.setTitle("Save Siembras", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //button.backgroundColor = UIColor.green
        return button
    }()
    
    let deleteButton: UIButton = {
       let button = UIButton()
        button.setTitle("Delete Siembras", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //button.backgroundColor = UIColor.green
        return button
    }()
    
    let updateButton: UIButton = {
       let button = UIButton()
        button.setTitle("Update Siembra", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //button.backgroundColor = UIColor.green
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: 5, paddingBottom: 0, paddingRight: 5)
        tableView.dataSource = self
        
        /*
        view.addSubview(saveButton)
        saveButton.anchor(top: tableView.bottomAnchor, bottom: nil, paddingTop: 10, paddingBottom: 0, width: 200, height: 50)
        
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
        */
        load()
    }

    
    @objc func load(){
        sharedSubzoneInstance.getByIdRequest(url: "http://granjapp2.appspot.com/subzone/", id: "\(subzoneid!)" ){(result, error) in
        if error == nil {
            DispatchQueue.main.async {
                actualsubzone = result
                plants = actualsubzone?.plantings
                print(plantings)
                self.tableView.reloadData()
            }
        }
            
        /*
        sharedPlantingInstance.getRequest(url: "http://localhost:10010/planting"){(str, array, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.siembras = array
                    print(array)
                    self.tableView.reloadData()
                }
            }
        }*/
    }
    }
    
    @objc func save(){
        saveButton.setTitleColor(UIColor.blue, for: .normal)
        let tmp = ["salud": 2, "cultivo": 1, "subzona": 1] as [String : Any]
            sharedPlantingInstance.postRequest(url: "http://localhost:10010/planting", body: tmp)
    }
    
    
    @objc func deleteresource(){
        deleteButton.setTitleColor(UIColor.blue, for: .normal)
        sharedPlantingInstance.deleteRequest(url: "http://localhost:10010/planting/", id: "3")
    }
    
    
    @objc func updateresource(){
        updateButton.setTitleColor(UIColor.blue, for: .normal)
        sharedPlantingInstance.putRequest(url: "http://localhost:10010/planting/", id: "4", salud:3, cultivo: 2, subzona: 2)
    }
}
extension PlantingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return siembras!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PlantingCell
        //cell.textLabel?.text =
        cell.siembra = siembras?[indexPath.row]
        return cell
    }
    
    
}


