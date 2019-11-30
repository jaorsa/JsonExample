//
//  LoginController.swift
//  JsonExample
//
//  Created by Administrador on 07/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit
/*
var usernameTextField: UITextField = {
    let textf = UITextField()
    return textf
}()

var passwordTextField: UITextField = {
    let textf = UITextField()
    return textf
}()


let loginButton: UIButton = {
    let button = UIButton()
    button.setTitle("LOG IN ", for: .normal)
    button.backgroundColor = UIColor(named: "blueGreen")
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
    button.layer.cornerRadius = 5
   
    return button
}()


class LoginController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        //loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    /*
    @objc func login(){
        
        if dataTask != nil{
            dataTask?.cancel()
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let usernameStr = usernameTextField.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let passwordStr = passwordTextField.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = NSURL(string: "http://www.iroseapps.com/moviles/login.php?username=\(usernameStr)&password=\(passwordStr)")
        let request = URLRequest(url: url! as URL)
        dataTask = defaultSession.dataTask(with: request) {
            data, response,error in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            if let error = error {
                print(error.localizedDescription)
            }
            else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.showResult(data)
                    }
                }
            }
        }
        
    }*/
    
    func showResult(data: Data){
        let str = NSString(data: data, encoding: String.Encoding.ascii.rawValue)
        let alert =  UIAlertController(title: "Server Response", message: (str! as String), preferredStyle: .alert)
        let action = UIAlertAction(title: "Server Response", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
}
*/
