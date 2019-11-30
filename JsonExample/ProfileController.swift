//
//  ProfileController.swift
//  GranjApp
//
//  Created by Administrador on 25/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

//Properties
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Grass")
        view.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.anchor(top: view.topAnchor, paddingTop: 72,  width: 120, height: 120)
        profileImageView.layer.cornerRadius = 120 / 2
        /*view.addSubview(messageButton)
        messageButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 32, width: 32, height:32 )*/
         view.addSubview(followButton)
        followButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: 20, paddingRight: 32, width: 40, height:32 )
        //followButton.addTarget(self, action: #selector(updateresource), for: .touchUpInside)
        
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)
        
        view.addSubview(lastnameLabel)
        lastnameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lastnameLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 12)
        
        view.addSubview(emailLabel)
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.anchor(top: lastnameLabel.bottomAnchor, paddingTop: 5)
        
        return view
    }()



let profileImageView: UIImageView = {
    let tmp = UIImageView()
    tmp.image = #imageLiteral(resourceName: "images")
    tmp.contentMode = .scaleAspectFill
    tmp.clipsToBounds = true
    tmp.layer.borderWidth = 3
    tmp.layer.borderColor = UIColor.white.cgColor
    return tmp
}()

let messageButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "email").withRenderingMode(.alwaysOriginal), for: .normal)
    return button
    
}()

let followButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("done", for: .normal)
    button.setTitleColor(.white, for: .normal)
    //button.setImage(#imageLiteral(resourceName: "addUser").withRenderingMode(.alwaysOriginal), for: .normal)
    return button
    
}()


let nameLabel: UITextField = {
   let label = UITextField()
    label.textAlignment = .center
    label.text = usuario?.name
    label.font = UIFont(name: "AvenirNext-Bold", size: 26)
    label.textColor = .white
    return label
}()

let emailLabel: UILabel = {
   let label = UILabel()
    label.textAlignment = .center
    label.text = usuario?.correo
    label.font = UIFont(name: "AvenirNext-Default", size: 16)
    label.textColor = .white
    return label
}()

let lastnameLabel: UITextField = {
   let label = UITextField()
    label.textAlignment = .center
    label.text = usuario?.lastname
    label.font = UIFont(name: "AvenirNext-Bold", size: 26)
    label.textColor = .white
    return label
}()

//Lifecycle
class ProfileController: UIViewController{


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let button = followButton
        button.addTarget(self, action: #selector(updateresource), for: .touchUpInside)
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Perfil"
        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 350)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func updateresource(){
        guard let nombre = nameLabel.text, nameLabel.hasText else{
            nameLabel.placeholder = "Nombre"
            return
        }
        
        guard let lastname = lastnameLabel.text, lastnameLabel.hasText else{
            lastnameLabel.placeholder = "Apellido"
            return
        }
        let tmp = ["name": nameLabel.text, "lastname": lastnameLabel.text, "correo": usuario!.correo, "estrellas": usuario!.estrellas, "admin": usuario!.admin ] as [String:Any]
        sharedUsersInstance.putRequest(url: "http://granjapp2.appspot.com/users/", id: "\(usuario!.id)", body: tmp)
        sharedUsersInstance.getByIdRequest(url: "http://granjapp2.appspot.com/users/", id: "\(usuario!.id)") {(result, error) in
            if error == nil {
                DispatchQueue.main.async {
                    usuario = result
                    print(usuario)
                }
                //
            }
            
        }
    }
}




