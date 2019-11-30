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
var cultivos: [Cultivos]?
var subzoneid: Int?
class SubzoneViewController: UIViewController {
    var refresher: UIRefreshControl!
    var subzoneid: Int?
    var tmp: Zone?
    var subzonas: [subzone]?
    var subzona: Subzone?
    var crops: [Cultivos] = []
    
    var plantings: [Planting]?
    
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
        button.setTitleColor(UIColor.lightGray, for: .normal)
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
        // Do any additional setup after loading the view.
        view.addSubview(addButton)
        addButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 250, paddingBottom: 0, paddingRight: 20, height: 30)
        addButton.addTarget(self, action: #selector(handleaddSubzone), for: .touchUpInside)
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 150, paddingLeft: 5, paddingBottom: 0, paddingRight: 20, height: 500)
        tableView.dataSource = self
        tableView.delegate = self
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
        load(id: (zoneid)!)
        loadcultivos()
    }
    
    
    
    @objc func handleaddSubzone(){
        let controller = AddASubzoneViewController()
        controller.delegate = self
        self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
    
    @objc func handleload(){
        refresher.endRefreshing()
    }
    
    
    func load(id: Int){
        sharedZoneInstance.getByIdRequest(url: "http://granjapp2.appspot.com/zone/", id: "\(id)"){ (result, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.tmp = result
                    print(result)
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
                    print("result")
                    print(self.subzona)
                    siembras = self.subzona?.plantings
                    print("siembras")
                    print(siembras)
                    self.refresher.endRefreshing()
                }
            }
        
        }
    }
    
    func loadcultivos(){
        sharedCultivoInstance.getRequest(url: "http://granjapp2.appspot.com/crops"){(str, array, error) in
            if error == nil {
                DispatchQueue.main.async {
                    //self.usuarios = array
                    self.crops = array
                    //print(array)
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
        cell.textLabel?.text = subzonas![indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cultivos = crops
        subzoneid = subzonas?[indexPath.row].id
        print(cultivos)
        print("done")
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
        self.tableView.reloadData()
    }
    
}


