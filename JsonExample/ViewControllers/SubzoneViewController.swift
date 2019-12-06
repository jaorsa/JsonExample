//
//  ViewController.swift
//  JsonExample
//
//  Created by Administrador on 07/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TodoCell"
var siembras: [planting]?
var plantings: [Planting]?
//var cultivos: [Cultivos]?
var subzoneid: Int? = 0
class SubzoneViewController: UIViewController {
    var refresher: UIRefreshControl!
    var tmp: Zone?
    var subzonas: [subzone]?
    var subzona: Subzone?
    
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
        table.register(TodoCell.self, forCellReuseIdentifier: reuseIdentifier)
        table.rowHeight = 50
        return table
    }()
    
    let loadButton: UIButton = {
       let button = UIButton()
        button.setTitle("Load Usuarios", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //button.backgroundColor = UIColor.green
        return button
    }()
    
    let deleteButton: UIButton = {
       let button = UIButton()
        button.setTitle("Delete Usuarios", for: .normal)
        button.setTitleColor(UIColor.clear, for: .normal)
        
        //button.backgroundColor = UIColor.green
        return button
    }()
    
    let updateButton: UIButton = {
       let button = UIButton()
        button.setTitle("Update Usuario", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //button.backgroundColor = UIColor.green
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "ForestGreen")
        // Do any additional setup after loading the view.
        view.addSubview(addButton)
        addButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 65, paddingLeft: 0, paddingBottom: 0, paddingRight: 50, height: 30)
        addButton.addTarget(self, action: #selector(handleaddSubzone), for: .touchUpInside)
        
        view.addSubview(tableView)
        tableView.anchor(top: addButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 500)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Jala para cargar")
        refresher.addTarget(self, action: #selector(handleload), for: .valueChanged)
        tableView.addSubview(refresher)
        
        view.addSubview(deleteButton)
        deleteButton.anchor(top: tableView.bottomAnchor, bottom: nil, paddingTop: 10, paddingBottom: 0, width: 200, height: 50)
        
        deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deleteButton.addTarget(self, action: #selector(deleteresource), for: .touchUpInside)
        
        
        view.addSubview(updateButton)
        updateButton.anchor(top: deleteButton.bottomAnchor, bottom: nil, paddingTop: 10, paddingBottom: 0, width: 200, height: 50)
        
        updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        updateButton.addTarget(self, action: #selector(updateresource), for: .touchUpInside)
        load(id: (zoneid) ?? 8)
        
    }
    
    
    
    @objc func handleaddSubzone(){
        if usuario?.admin != teamid{
            if teamid == nil{
                let alert = UIAlertController(title: "No es posible agregar zona", message: "No perteneces a un equipo", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "No es posible agregar zona", message: "No eres administrador del equipo", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let controller = AddASubzoneViewController()
            controller.delegate = self
            self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        }
    }
    
    @objc func handleload(){
        load(id: zoneid!)
    }
    
    
    func load(id: Int){
        sharedZoneInstance.getByIdRequest(url: "http://granjapp2.appspot.com/zone/", id: "\(id)"){ (result, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.tmp = result
                    
                    self.subzonas = self.tmp?.subzones
                    self.tableView.reloadData()
                    self.refresher.endRefreshing()
                }
            }
        }
    }
    
    func loadsubzona(id: Int){
        sharedSubzoneInstance.getByIdRequest(url: "http://granjapp2.appspot.com/subzone/", id: "\(id)") {(result, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.subzona = result
                    
                    siembras = self.subzona?.plantings
                    
                    self.refresher.endRefreshing()
                }
            }
        
        }
    }
    
    
    
    @objc func save(body: [String:Any]){
            sharedSubzoneInstance.postRequest(url: "http://granjapp2.appspot.com/subzone", body: body)
    }
    
    
    @objc func deleteresource(id: String){
        deleteButton.setTitleColor(UIColor.blue, for: .normal)
        sharedSubzoneInstance.deleteRequest(url: "http://granjapp2.appspot.com/subzone/", id: id)
    }
    
    
    @objc func updateresource(){
        updateButton.setTitleColor(UIColor.blue, for: .normal)
        let tmp = ["name": "gracias dios", "zone": 5] as [String:Any]
        sharedSubzoneInstance.putRequest(url: "http://granjapp2.appspot.com/subzone/", id: "7", body: tmp)
    }
}
extension SubzoneViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subzonas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "Subzona: " + subzonas![indexPath.row].name!
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "AvenirNext-Bold", size: 16)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        subzoneid = subzonas?[indexPath.row].id
        navigationController?.pushViewController(PlantingViewController.init(), animated: true)
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteresource(id: String(subzonas![indexPath.row].id))
            subzonas!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
extension SubzoneViewController: AddSubzoneDelegate{
    
    func addSubzone(name: String) {
        self.dismiss(animated: true)
        //self.activities.append(activity)
        let subzone = ["name": name, "zone":zoneid!] as [String:Any]
        self.save(body: subzone)
        load(id: zoneid!)
        self.tableView.reloadData()
    }
    
}


