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
    
    let popUpWindow: PopTeamsWindow = {
       let view = PopTeamsWindow()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
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
        //addButton.addTarget(self, action: #selector(handleaddZone), for: .touchUpInside)
        
        
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
        }else{
            sharedTeamInstance.getByIdRequest(url: "http://granjapp2.appspot.com/teams/", id: "\(teamid!)") {(userteam, error) in
            if error == nil {
                DispatchQueue.main.async {
                    equipo = userteam
                    teamusers = equipo?.usuarios
                    animals = equipo?.animals
                    zon = equipo?.zones
                    print(zon)
                    print(equipo)
                    print(animals)
                self.tableView.reloadData()
                
                }
                //self.refresher.endRefreshing()
            }
        }
        }
        
    }
    
    @objc func handleShowPopUp(){
        print("boton presionado")
        print(equipos)
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
    
    
    @objc func updateresource(){
        sharedAnimalInstance.putRequest(url: "http://granjapp2.appspot.com/animal/", id: "11", fechaNacimiento: "2012-11-04T14:51:06.157Z", no_h: 1, no_m: 2, salud: 1, especie: 1, etapa: 2)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animal = animals?[indexPath.row]
        let controller = ViewAnimalController()
        controller.animal = animal
        print(animal)
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
}


