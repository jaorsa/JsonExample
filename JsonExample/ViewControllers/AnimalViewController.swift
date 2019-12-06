//
//  ViewController.swift
//  JsonExample
//
//  Created by Administrador on 07/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "AnimalCell"

var teamusers: [Usuarios]?
class AnimalViewController: UIViewController {
    //var animals: [Animal] = []
    var refresher: UIRefreshControl!
    var teamInfoHeader: TeamInfoHeader!
    var animalid: Int?
    var usuariost: Usuarios?
    var tmpusuarios = [Usuarios]()
    
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(AnimalCell.self, forCellReuseIdentifier: reuseIdentifier)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 60)
        teamInfoHeader = TeamInfoHeader(frame: frame)
        //tableView.tableHeaderView = teamInfoHeader
        view.addSubview(teamInfoHeader)
        teamInfoHeader.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 80)
        
        view.addSubview(addButton)
        addButton.anchor(top: teamInfoHeader.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 3, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, height: 20)
        addButton.addTarget(self, action: #selector(handleaddAnimal), for: .touchUpInside)
        
        
        view.addSubview(tableView)
        tableView.anchor(top: addButton.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
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
        
        load()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        load()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
            load()
           navigationController?.setNavigationBarHidden(true, animated: false)
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           navigationController?.setNavigationBarHidden(false, animated: true)
       }

    @objc func load(){
        if teamid == nil{
            animals = []
            let presuser = Usuarios(id: usuario!.id, name: usuario?.name, lastname: usuario?.lastname, correo: usuario?.correo, estrellas: usuario?.estrellas, admin: usuario?.admin)
            self.tmpusuarios.append(presuser)
            //teamusers?.append(presuser)
            
        }else{
            sharedTeamInstance.getByIdRequest(url: "http://granjapp2.appspot.com/teams/", id: "\(teamid!)") {(userteam, error) in
            if error == nil {
                DispatchQueue.main.async {
                    equipo = userteam
                    teamusers = equipo?.usuarios
                    animals = equipo?.animals
                    zon = equipo?.zones
                    
                self.tableView.reloadData()
                self.refresher.endRefreshing()
                }
                
            }
        }
        }
        
    }
    
    @objc func handleaddAnimal(){
        let controller = AddAnimalBed()
        controller.delegate = self
        self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
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
    
    func save(body: [String:Any]){
        sharedAnimalInstance.postRequest(url: "http://granjapp2.appspot.com/animal", body: body){ (success) in
            if success{
                
            }
        }
    }
    
    
    @objc func deleteresource(){
        sharedAnimalInstance.deleteRequest(url: "http://granjapp2.appspot.com/animal/", id: "12")
    }
    
}
extension AnimalViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AnimalCell
        //cell.deleg = self
        cell.animal = animals![indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if teamid == usuario?.admin{
                sharedActivitiesInstance.deleteRequest(url: "http://granjapp2.appspot.com/animal/", id: "\(animals?[indexPath.row].id)"){(sucess) in
                    if sucess == true{
                        DispatchQueue.main.async {
                             let alert = UIAlertController(title: "Camada eliminada", message: "La camada se ha eliminado con exito", preferredStyle: .alert)
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
                let alert = UIAlertController(title: "No es posible eliminar camada " + "\(animals![indexPath.row].name) ", message: "No eres administrador del equipo", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animal = animals?[indexPath.row]
        let controller = ViewAnimalController()
        controller.animal = animal
        
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
}
extension AnimalViewController: AddAnimalBedDelegate {
    func addanimal(animal: [String : Any]) {
        self.dismiss(animated: true)
        save(body: animal)
        tableView.reloadData()
    }
    
    
}

extension AnimalViewController: PopUpDelegate {
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

