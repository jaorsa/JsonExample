//
//  ViewController.swift
//  JsonExample
//
//  Created by Administrador on 07/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ZoneCell"

var zoneid: Int?
class ZoneViewController: UIViewController {
    //var zonas: [zone]?
    var zona: Zone?
    var subzonas: [subzone]?
    var refresher: UIRefreshControl!
    var teamInfoHeader: TeamInfoHeader!
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(ZoneCell.self, forCellReuseIdentifier: reuseIdentifier)
        table.rowHeight = 50
        return table
    }()
    
    let efectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light )
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var popUpWindow: PopTeamsWindow = {
       let view = PopTeamsWindow()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.delegate = self
        return view
    }()
    
    let addButton: UIButton = {
       let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.setTitleColor(.white, for: .highlighted)
        return button
    }()
    
    let loadButton: UIButton = {
       let button = UIButton()
        button.setTitle("Load Usuarios", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        //button.backgroundColor = UIColor.green
        return button
    }()
    
    let saveButton: UIButton = {
       let button = UIButton()
        button.setTitle("Save Usuario", for: .normal)
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
        load()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        let frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 60)
        teamInfoHeader = TeamInfoHeader(frame: frame)
        //tableView.tableHeaderView = teamInfoHeader
        view.addSubview(teamInfoHeader)
        teamInfoHeader.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 80)
        
        
        view.addSubview(addButton)
        addButton.anchor(top: teamInfoHeader.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, height: 30)
        addButton.addTarget(self, action: #selector(handleaddZone), for: .touchUpInside)
        
        view.addSubview(tableView)
        tableView.anchor(top: addButton.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 20, paddingRight: 15)
        tableView.dataSource = self
        tableView.delegate = self
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Jala para cargar")
        refresher.addTarget(self, action: #selector(load), for: .valueChanged)
        tableView.addSubview(refresher)
        
        
        let button = teamInfoHeader.TeamButton
        button.addTarget(self, action: #selector(handleShowPopUp), for: .touchUpInside)
        //tableView.tableFooterView = UIView()
        view.addSubview(efectView)
        efectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        efectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        efectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        efectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        efectView.alpha = 0
        
    }

    @objc func load(){
        if teamid == nil{
           
        }else{
            
            sharedTeamInstance.getByIdRequest(url: "http://granjapp2.appspot.com/teams/", id: "\(teamid!)") {(userteam, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        equipo = userteam
                        
                        zon =  equipo?.zones
                        self.refresher.endRefreshing()
                        self.tableView.reloadData()
                    }
                }
            }
            if zon?.isEmpty == false{
                
                for i in 0...(zon!.count)-1{
                    sharedZoneInstance.getByIdRequest(url: "http://granjapp2.appspot.com/zone/", id: "\(zon![i].id)") {(result, error) in
                        if error == nil {
                            DispatchQueue.main.async {
                                self.zona = result
                                
                                zones.append(result)
                                self.refresher.endRefreshing()
                            }
                            //
                        }
                        
                    }
                }
                
            }
            else{print("zonas esta vacía")}
        }
        
        
    }
    
    @objc func handleShowPopUp(){
        
        view.addSubview(popUpWindow)
        popUpWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        popUpWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpWindow.heightAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
         popUpWindow.widthAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        
        popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpWindow.alpha = 0
        
        UIView.animate(withDuration: 0.5){
            self.efectView.alpha = 1
            self.popUpWindow.alpha = 1
            self.popUpWindow.transform = CGAffineTransform.identity
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
               super.viewWillAppear(animated)
        //load()
               navigationController?.setNavigationBarHidden(true, animated: false)
           }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //load()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
           
           override func viewWillDisappear(_ animated: Bool) {
               super.viewWillDisappear(animated)
               navigationController?.setNavigationBarHidden(false, animated: true)
           }
    
    @objc func handleaddZone(){
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
        }
        else{
            let controller = AddAZoneViewController()
            controller.delegate = self
            self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        }
    }
    
    @objc func save(body: [String:Any]){
        //let tmp = ["name": "zona segura"] as [String : Any]
            sharedZoneInstance.postRequest(url: "http://granjapp2.appspot.com/zone", body: body)
        load()
    }
    
    
    @objc func deleteresource(id: String){
        deleteButton.setTitleColor(UIColor.blue, for: .normal)
        sharedZoneInstance.deleteRequest(url: "http://granjapp2.appspot.com/zone/", id: id)
    }
    
    
    @objc func updateresource(){
        updateButton.setTitleColor(UIColor.blue, for: .normal)
        let tmp = ["name": "gracias dios"] as [String:Any]
        sharedZoneInstance.putRequest(url: "http://granjapp2.appspot.com/zone/", id: "7", body: tmp)
    }
}
extension ZoneViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zon?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ZoneCell
        //cell.deleg = self
        cell.textLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        cell.textLabel?.text = "Zona: " + (zon?[indexPath.row].name)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubzoneViewController") as! SubzoneViewController
        zoneid = zones[indexPath.row]?.id
        
        //controller.subzonas = subzonas
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                if teamid == usuario?.admin{
                    sharedActivitiesInstance.deleteRequest(url: "http://granjapp2.appspot.com/zone/", id: "\(zones[indexPath.row]?.id)"){(sucess) in
                        if sucess == true{
                            DispatchQueue.main.async {
                                 let alert = UIAlertController(title: "Zona eliminada", message: "La zona se ha eliminado con exito", preferredStyle: .alert)
                                                       let action = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
                                                       }
                                                       alert.addAction(action)
                                                       self.present(alert, animated: true, completion: nil)
                                                       self.load()
                            }
                        }
                    }
                }
                else{
                    let alert = UIAlertController(title: "No es posible eliminar zona", message: "No eres administrador del equipo", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
}

extension ZoneViewController: AddZoneDelegate{
    func addZone(zone: [String:Any]) {
        self.dismiss(animated: true)
        //self.activities.append(activity)
        self.save(body: zone)
        self.tableView.reloadData()
    }
    
}

extension ZoneViewController: PopUpDelegate {
    func handleDismissal() {
        UIView.animate(withDuration: 0.5, animations: {
            self.efectView.alpha = 0
            self.popUpWindow.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }){
            (_) in
            self.popUpWindow.removeFromSuperview()
            
        }
        load()
    }
}


