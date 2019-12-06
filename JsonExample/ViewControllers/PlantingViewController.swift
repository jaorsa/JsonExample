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

var cultivos: [Crop]?
var siembraprinc: Planting?
var aplicaciones: [Applications]?
var recursos: [Resource]?
var siembraid: Int?
class PlantingViewController: UIViewController {
    //var siembras: [Planting] = []
    var crops = [Crop]()
    var plants = [planting]()
    
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
        table.rowHeight = 65
        
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
        
        view.backgroundColor = UIColor(named: "ForestGreen")
        load()
        /*view.addSubview(addButton)
        addButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 65, paddingLeft: 0, paddingBottom: 0, paddingRight: 50, height: 30)
        //addButton.addTarget(self, action: #selector(handleaddSubzone), for: .touchUpInside)
        */
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
    }
    
    @objc func load(){
        var plans: [planting]?
        
        sharedCultivoInstance.getRequest(url: "http://granjapp2.appspot.com/crops/"){ (crop,error) in
            if error == nil{
                DispatchQueue.main.async {
                    cultivos = crop
                    print(crop)
                    print(subzoneid)
                    for i in 0...cultivos!.count-1{
                        plans = cultivos![i].plantings
                        if plans != nil{
                            if plans!.count >= 1{
                                for j in 0...plans!.count-1{
                                    if plans?[j].subzona == subzoneid!{
                                        self.crops.append(cultivos![i])
                                        self.plants.append(plans![j])
                                        
                                    }
                                }
                            }
                            
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            }
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
        return crops.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PlantingCell
        cell.delegate = self
        cell.cultivo = crops[indexPath.row]
        cell.siembra = plants[indexPath.row]
        return cell
    }
    
    
}

extension PlantingViewController: PlantingCellDelegate{
    func segueApplications(cell: PlantingCell) {
        sharedPlantingInstance.getByIdRequest(url: "http://granjapp2.appspot.com/planting/", id: "\(cell.siembra!.id)"){(siembra, error) in
            if error == nil{
                DispatchQueue.main.async {
                    siembraprinc = siembra
                    aplicaciones = siembraprinc!.aplicaciones
                    siembraid = siembraprinc?.id
                        
                    }
                }
                
            }
            self.navigationController?.pushViewController(ApplicationViewController.init(), animated: true)
        }
        
    }


