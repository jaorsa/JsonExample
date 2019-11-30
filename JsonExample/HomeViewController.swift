//
//  HomeViewController.swift
//  JsonExample
//
//  Created by Administrador on 26/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

var emailTextField: UITextField? = {
    let textf = UITextField()
    return textf.textField(withPlaceholder: "Email", isSecureEntry: false )
}()

var passwordTextField: UITextField? = {
    let textf = UITextField()
    return textf.textField(withPlaceholder: "Password", isSecureEntry: true)
}()


var actividades: [Activities]?
var iduser: Int?
var teamid: Int?
var usuario: Users?
var users: [Users]?
var rol: [String]?
var equipo: Teams?
var animals: [Animal]?
var zon: [zone]?
var zones = [Zone?]()

var roles: [Roles]?
var equipos: [Equipos]?
class HomeViewController: UIViewController {
    var usuarios: [Users] = []
    var rols: [Roles] = []
    
    
    
    var appImageView: UIImageView? = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = #imageLiteral(resourceName: "GranjApp_Cabeza")
        return view
        }()

    

    var emailContainer: UIView? = {
        let view = UIView()
        emailTextField?.autocapitalizationType = .none
        return view.textViewContainer(view: view, image: #imageLiteral(resourceName: "mail"), textfield: emailTextField!)
    }()

    var passwordContainer: UIView? = {
        let view = UIView()
        return view.textViewContainer(view: view, image: #imageLiteral(resourceName: "shield"), textfield: passwordTextField!)
    }()

    

    let loginButton: UIButton? = {
        let button = UIButton()
        button.setTitle("LOG IN ", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor(named: "Grass"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        button.layer.cornerRadius = 5
       
        return button
    }()

    let doesntHaveAccount: UIButton? = {
        let button = UIButton(type: .system)
        let attributedTittle = NSMutableAttributedString(string: "No tienes una cuenta? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white ])
        attributedTittle.append(NSAttributedString(string: "Registrate", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white ]))
        button.setAttributedTitle(attributedTittle, for: .normal)
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        //emailTextField?.delegate = self
        //passwordTextField?.delegate = self
        load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func signUp(){
        print("el usuario se ha registrado")
        navigationController?.pushViewController(SignUpController.init(), animated: true)
        
    }
    @objc func login()->Bool{
        print("el usuario ha iniciado sesión")
        if (emailTextField?.isValidEmail(emailStr: (emailTextField?.text!)!))!{
            if (passwordTextField?.isPasswordValid(passwordTextField!.text!))!{
                if usuarios.count >= 1{
                
                for i in 0...usuarios.count-1 {
                    if usuarios[i].correo == emailTextField?.text{
                        print(usuarios[i].correo)
                        usuario = usuarios[i]
                        iduser = usuarios[i].id
                        if usuario?.equipos?.isEmpty == false{
                            equipos = usuario?.equipos
                            teamid = equipos?[0].id
                            print(teamid)
                        }
                        if usuario?.activities?.isEmpty == false{
                        actividades = usuarios[i].activities
                        }
                        navigationController?.pushViewController(TabController.init(), animated: true)
                        //performSegue(withIdentifier: "TabController", sender: nil)
                        navigationController?.navigationBar.isHidden = false
                        emailTextField?.text = ""
                        emailTextField?.attributedPlaceholder = NSAttributedString(string: "Correo", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                        passwordTextField?.text = ""
                        passwordTextField?.attributedPlaceholder = NSAttributedString(string: "Contraseña", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                        return true
                    }
                }
                    if usuario == nil{
                        emailTextField?.text = ""
                        emailTextField?.attributedPlaceholder = NSAttributedString(string: "Correo no registrado", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                        return false
                    }
                //let test = ""
                //test.testUserFormat(name: "jaorsa", correo: "jaorsa@hotmail.com")
            }
                }
            else{
                passwordTextField?.text = ""
                passwordTextField?.attributedPlaceholder = NSAttributedString(string: "Contraseña no valida", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                return false
            }
            
        }
        else{
            emailTextField?.text = ""
            emailTextField?.attributedPlaceholder = NSAttributedString(string: "Correo no valido", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            return false
        }
        return true
    }
    
        func load(){
            
        sharedUsersInstance.getRequest(url: "http://granjapp2.appspot.com/users"){(success, array, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.usuarios = array
                    users = array
                    print(array)
                }
            }
        }
    }
    
    func configureView(){
        view.backgroundColor = UIColor(named: "App")
        //navigationController?.navigationBar.isHidden = true
        
        view.addSubview(appImageView!)
        appImageView!.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
        appImageView!.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(emailContainer!)
        emailContainer!.anchor(top: appImageView!.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 50, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(passwordContainer!)
        passwordContainer!.anchor(top: emailContainer!.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(loginButton!)
        loginButton!.anchor(top: passwordContainer!.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        view.addSubview(doesntHaveAccount!)
        doesntHaveAccount!.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 12, paddingRight: 32, width: 0, height: 50)
        
    }
    
}


