//
//  SignUpController.swift
//  GranjApp
//
//  Created by Administrador on 28/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit


var emailtextField: UITextField? = {
    let textf = UITextField()
    return textf.textField(withPlaceholder: "Email", isSecureEntry: false )
}()

var passwordtextField: UITextField? = {
    let textf = UITextField()
    return textf.textField(withPlaceholder: "Password", isSecureEntry: true)
}()

var usernametextField: UITextField? = {
    let textf = UITextField()
    return textf.textField(withPlaceholder: "Nombre", isSecureEntry: false)
}()

var lastnametextField: UITextField? = {
    let textf = UITextField()
    return textf.textField(withPlaceholder: "Apellidos", isSecureEntry: false)
}()


class SignUpController: UIViewController{
    
    let appImageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = #imageLiteral(resourceName: "GranjApp_Cabeza")
        return view
    }()

    var userContainer: UIView = {
        let view = UIView()
        usernametextField?.autocapitalizationType = .none
        return view.textViewContainer(view: view, image: #imageLiteral(resourceName: "user"), textfield: usernametextField!)
    }()
    
    var lastnameContainer: UIView = {
        let view = UIView()
        lastnametextField?.autocapitalizationType = .none
        return view.textViewContainer(view: view, image: #imageLiteral(resourceName: "user"), textfield: lastnametextField!)
    }()
    
    var emailContainer: UIView = {
        let view = UIView()
        emailtextField?.autocapitalizationType = .none
        return view.textViewContainer(view: view, image: #imageLiteral(resourceName: "mail"), textfield: emailtextField!)
    }()

    var passwordContainer: UIView = {
        let view = UIView()
        return view.textViewContainer(view: view, image: #imageLiteral(resourceName: "shield"), textfield: passwordtextField!)
    }()

    let etiqueta: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        label.text = "Contraseña debe incluir caracter especial, un número, una mayúscula y minúscula"
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 3
        label.textColor = .white
        return label
    }()

    let loginButton: UIButton? = {
        let button = UIButton()
        button.setTitle("REGISTRARSE", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor(named: "App"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        button.layer.cornerRadius = 5
       
        return button
    }()

    let alreadyHasAccount: UIButton? = {
        let button = UIButton(type: .system)
        let attributedTittle = NSMutableAttributedString(string: "Ya tienes una cuenta? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white ])
        attributedTittle.append(NSAttributedString(string: "Inicia Sesión", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white ]))
        button.setAttributedTitle(attributedTittle, for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
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
        guard let nombre = usernametextField!.text, usernametextField!.hasText else{
            usernametextField?.attributedPlaceholder = NSAttributedString(string: "Por favor ingrese un nombre", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            return
        }
        guard let apellido = lastnametextField!.text, lastnametextField!.hasText else{
            lastnametextField?.attributedPlaceholder = NSAttributedString(string: "Por favor ingrese un apellido", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            return
        }
        guard let correo = emailtextField!.text, emailtextField!.hasText else{
            emailtextField?.attributedPlaceholder = NSAttributedString(string: "Por favor ingrese un correo", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            return
        }
        guard let contraseña = passwordtextField!.text, passwordtextField!.hasText else{
            passwordtextField?.attributedPlaceholder = NSAttributedString(string: "Por favor ingrese contraseña", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            return
        }
        if checkifuserexists(){
            return
        }
        
        if (emailtextField?.isValidEmail(emailStr: (emailtextField?.text!)!))!{
            if (passwordtextField?.isPasswordValid(passwordtextField!.text!))!{
                let tmp = ["name": nombre, "lastname": apellido, "correo": correo, "estrellas": 1, "admin": -1 ] as [String:Any]
                sharedUsersInstance.postRequest(url: "http://granjapp2.appspot.com/users", body: tmp){ (success) in
                    if success == true{
                print("el usuario se ha registrado")
                        self.navigationController?.pushViewController(TabController.init(), animated: true)
                    }
                }
            }
            else{
                passwordtextField?.attributedPlaceholder = NSAttributedString(string: "Contraseña no segura", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            }
        }
        else{
            emailtextField?.attributedPlaceholder = NSAttributedString(string: "Correo no valido", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
    
    func checkifuserexists()->Bool{
        print(users)
        for i in 0...(users!.count)-1{
            if users?[i].correo == emailtextField?.text{
                emailtextField?.text = ""
                emailtextField?.attributedPlaceholder = NSAttributedString(string: "Correo ya registrado", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                return true
            }
        }
        return false
    }
    @objc func login(){
        print("el usuario ha iniciado sesión")
        if #available(iOS 13.0, *) {
            navigationController?.pushViewController(HomeViewController.init(), animated: true)
        } else {
            // Fallback on earlier versions
            navigationController?.pushViewController(HomeViewController.init(), animated: true)
        }
    }
    
    func configureView(){
        view.backgroundColor = UIColor(named: "App")
        //navigationController?.navigationBar.isHidden = true
        
        view.addSubview(appImageView)
        appImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
        appImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(userContainer)
        userContainer.anchor(top: appImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, height: 50)
        
        view.addSubview(lastnameContainer)
        lastnameContainer.anchor(top: userContainer.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, height: 50)
        
        view.addSubview(emailContainer)
        emailContainer.anchor(top: lastnameContainer.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, height: 50)
        
        view.addSubview(passwordContainer)
        passwordContainer.anchor(top: emailContainer.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, height: 50)
        
        view.addSubview(etiqueta)
        etiqueta.anchor(top: passwordContainer.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 6, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, height: 45)
        
        view.addSubview(loginButton!)
        loginButton!.anchor(top: etiqueta.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, height: 50)
        
        view.addSubview(alreadyHasAccount!)
        alreadyHasAccount!.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 12, paddingRight: 32,height: 50)
        
    }
    
    
    
}
