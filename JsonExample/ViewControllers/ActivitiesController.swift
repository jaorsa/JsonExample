//
//  ActivityController.swift
//  GranjApp
//
//  Created by Administrador on 24/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit


private let reuseIdentifier = "ActivitiesCell"


class ActivitiesController: UIViewController{
    var usuarios: [Users] = []
    var actividad: Activities?
    var roles: [Roles] = []
    var activities = [Activities]()
    var tableView: UITableView!
    var actlimit = 0
    var refresher: UIRefreshControl!
    var teamInfoHeader: TeamInfoHeader!
    var puntuacion = 0
    var terminadas = 0
    
    let actLabel: UILabel = {
        let label = UILabel()
        label.tintColor = UIColor.black
        label.text = "actividades"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let addButton: UIButton = {
       let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.setTitleColor(.white, for: .highlighted)
        return button
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
    
    let progressBar: UIProgressView = {
        let bar = UIProgressView(progressViewStyle: .bar)
        bar.setProgress(0.0, animated: true)
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.trackTintColor = .brown
        bar.tintColor = .green
        bar.layer.cornerRadius = 10
        bar.clipsToBounds = true
        return bar
    }()

    
    
    let topcontainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleaddActivity))
        view.backgroundColor = .white
        let frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 60)
        teamInfoHeader = TeamInfoHeader(frame: frame)
        //tableView.tableHeaderView = teamInfoHeader
        view.addSubview(teamInfoHeader)
        teamInfoHeader.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 80)
        configureView()
        configureTableView()
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
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
            
           navigationController?.setNavigationBarHidden(true, animated: false)
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           navigationController?.setNavigationBarHidden(false, animated: true)
       }
       
    func configureTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 65
       tableView.register(ActivitiesCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.anchor(top: topcontainer.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Jala para cargar")
        refresher.addTarget(self, action: #selector(load), for: .valueChanged)
        tableView.addSubview(refresher)
        
    }
    
    
    func configureView(){
        
        view.addSubview(topcontainer)
        topcontainer.anchor(top: teamInfoHeader.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50)
        
        topcontainer.addSubview(addButton)
        addButton.anchor(top: topcontainer.topAnchor, bottom: nil, right: topcontainer.rightAnchor, paddingTop: 10, paddingBottom: 0, paddingRight: 50)
        addButton.addTarget(self, action: #selector(handleaddActivity), for: .touchUpInside)
        topcontainer.addSubview(progressBar)
        progressBar.anchor(top: topcontainer.topAnchor, left: topcontainer.leftAnchor, bottom: nil, right: addButton.leftAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 30, height: 15)
        topcontainer.addSubview(actLabel)
        actLabel.anchor(top: progressBar.bottomAnchor, left: topcontainer.leftAnchor, bottom: nil, right: topcontainer.rightAnchor, paddingTop: 3, paddingLeft: 10, paddingBottom: 0, paddingRight: 20,height: 15)
    }
    
    
    func save(tmp: [String:Any]){
        sharedActivitiesInstance.postRequest(url: "http://granjapp2.appspot.com/activities", body: tmp)
    }
    
    func updateresource(){
        let body = ["id": actividad!.id, "name": actividad!.name!, "fechaInicio": actividad!.fechaInicio!, "terminado": 1, "descripcion": actividad!.descripcion!, "complejidad": actividad!.complejidad!, "usuario":actividad!.usuario, "calificacion": actividad!.calificacion, "equipo": actividad!.equipo] as [String : Any]
        sharedActivitiesInstance.putRequest(url: "http://granjapp2.appspot.com/activities/",id: "\(actividad!.id)",body: body){(success) in
            if success == true{
                DispatchQueue.main.async {
                    sharedUsersInstance.getByIdRequest(url: "http://granjapp2.appspot.com/users/", id: "\((self.actividad!.usuario)!)"){ (response,error) in
                        DispatchQueue.main.async {
                            let user = response
                            
                            let usertmp = ["id": user.id,"name": user.name!, "lastname": user.lastname!, "correo": user.correo!, "estrellas": (user.estrellas! + self.puntuacion), "admin": user.admin!, "password": user.password!] as [String:Any]
                            
                            sharedUsersInstance.putRequest(url: "http://granjapp2.appspot.com/users/", id: "\(user.id)", body: usertmp)
                        }
                    }
                }
            }
            
        }
        
        
    }
    
    
    @objc func load(){
        if teamid == nil{
            sharedUsersInstance.getByIdRequest(url: "http://granjapp2.appspot.com/users/", id: "\(iduser!)"){(user, error) in
            if error == nil {
                DispatchQueue.main.async {
                    usuario = user
                    self.activities = usuario!.activities!
                    
                    self.tableView.reloadData()
                    self.refresher.endRefreshing()
                    }
                }
            }
        }
        else{
            sharedTeamInstance.getByIdRequest(url: "http://granjapp2.appspot.com/teams/", id: "\(teamid!)"){(team, error) in
            if error == nil {
                DispatchQueue.main.async {
                    equipo = team
                    self.activities = equipo!.actividades!
                    
                    self.tableView.reloadData()
                    self.refresher.endRefreshing()
                    self.actlimit = self.activities.count
                    
                    if self.activities != nil{
                        self.actLabel.text = "\(self.terminadas)" + " / " + "\(self.activities.count) " + "terminadas"
                        }
                    }
                }
            }
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
    
    
    @objc func handleaddActivity(){
        let controller = AddActivityController()
        controller.delegate = self
        self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewActivityController" {
            let dest =  segue.destination as! ViewActivityController
            dest.activity = sender as? Activities
        }
    }
    
}

extension ActivitiesController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ActivitiesCell
        cell.deleg = self
        cell.activity = activities[indexPath.row]
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activity = activities[indexPath.row]
        let controller = ViewActivityController()
        controller.activity=activity
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.navigationBar.isHidden = false
        //performSegue(withIdentifier: "ViewActivityController", sender: activity)
    }
        */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if teamid == usuario?.admin{
                sharedActivitiesInstance.deleteRequest(url: "http://granjapp2.appspot.com/activities/", id: "\(activities[indexPath.row].id)"){(sucess) in
                    if sucess == true{
                        DispatchQueue.main.async {
                             let alert = UIAlertController(title: "Actividad eliminada", message: "La actividad se ha eliminado con exito", preferredStyle: .alert)
                                                   let action = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
                                                   }
                                                   alert.addAction(action)
                                                   self.present(alert, animated: true, completion: nil)
                                                   //tableView.deleteRows(at: [indexPath], with: .automatic)
                                                   //self.tableView.reloadData()
                                                   self.load()
                        }
                    }
                }
            }
            else{
                let alert = UIAlertController(title: "No es posible eliminar actividad", message: "No eres administrador del equipo", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction) in
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension ActivitiesController: AddActivitiesDelegate {
    func addActivity(activity: [String:Any]) {
        self.dismiss(animated: true)
        save(tmp: activity)
        tableView.reloadData()
        actlimit += 1
    }
    
}

extension ActivitiesController: DeleteActivitiesDelegate{
    
    func deleteActivities(cell: ActivitiesCell) {
        var grade = 0
        var terminar = 0
        guard var act = cell.activity else{
        
        return}
        
        let alertTittle = "Actividad Completada"
        let message = "La actividad \(act.name) ha sido completada"
        let alert = UIAlertController(title: alertTittle, message: message, preferredStyle: .alert)
        alert.addTextField{ (textfield) in
            textfield.placeholder = "Calificacion entre 1 y 5"
        }
    
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            let textField = alert.textFields![0] // Force unwrapping because we know it exists.
            guard let cali = textField.text, textField.hasText else {
                return
            }
            print("Text field: \(textField.text ?? "")")
            self.actividad = act
            
            if Int(cali) != nil{
                let intcalificacion = Int(cali)!
                self.actividad!.calificacion! += intcalificacion
            }else{
                textField.text = ""
                textField.placeholder = "Por favor ingrese una cantidad"
                return
            }
            
            self.terminadas+=1
            self.actLabel.text = "\(self.terminadas)" + " / " + "\(self.activities.count) " + "terminadas"
            self.puntuacion = self.actividad!.calificacion! * self.actividad!.complejidad!
            self.updateresource()
                self.tableView.reloadData()
                self.progressBar.progress += Float(1.0/Float(self.actlimit))
                self.progressBar.setProgress(self.progressBar.progress, animated: true)
                if Int(self.progressBar.progress) == 1{
                    self.progressBar.progress = 0
                }
                
            }
        ))
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension ActivitiesController: PopUpDelegate {
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
