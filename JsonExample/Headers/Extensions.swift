//
//  Extensions.swift
//  GranjApp
//
//  Created by Administrador on 28/10/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0,paddingLeft: CGFloat?=0,paddingBottom: CGFloat? = 0,paddingRight: CGFloat?=0, width: CGFloat? = nil, height:CGFloat? = nil){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            topAnchor.constraint(equalTo: top,constant: paddingTop!).isActive = true
        }
        
        if let left = left{
            leftAnchor.constraint(equalTo: left,constant: paddingLeft!).isActive = true
        }
        
        if let bottom = bottom {
            if let paddingBottom = paddingBottom{
                bottomAnchor.constraint(equalTo: bottom,constant: -paddingBottom).isActive = true
            }
            
        }
        
        if let right = right {
            if let paddingRight = paddingRight{
                rightAnchor.constraint(equalTo: right,constant: -paddingRight).isActive = true
            }
            
        }
        
        if let width = width{
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height{
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        
        

        //fade out
        
    }
    func textViewContainer(view: UIView, image: UIImage, textfield: UITextField) -> UIView{
        view.backgroundColor = .clear
        let imageView = UIImageView()
        imageView.image = image
        imageView.alpha = 0.87
        
        view.addSubview(imageView)
        imageView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(textfield)
        textfield.anchor(top: nil, left: imageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 8, height: 50)
        textfield.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let separator = UIView()
        separator.backgroundColor = UIColor(white: 1, alpha: 0.87)
        view.addSubview(separator)
        separator.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, height: 0.75)
        
        
        return view
    }
    
    
}

extension UITextField{
    func textField(withPlaceholder placeholder: String, isSecureEntry: Bool ) -> UITextField{
        let texf = UITextField()
        texf.borderStyle = .none
        texf.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        texf.textColor = .white
        texf.isSecureTextEntry = isSecureEntry
        texf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return texf
    }
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,16}")
        return passwordTest.evaluate(with: password)
    }
    /*
    func isActivityValid(activityname: String) -> Bool{
        let activityNameRegEx = "[A-Z0-9a-z._%+-]{1,50}"
        let activityTest = NSPredicate(format: "SELF MATCHES %@", activityNameRegEx)
        return activityTest.evaluate(with: activityname)
    }
    
    func isComplexityValid(complexity: Int) -> Bool{
        if complexity >= 1 && complexity <= 5{
            return true
        }
        else{
            return false
        }
    }
    
    func isUsername(name: String) -> Bool{
        let userNameRegEx = "[A-Z]|[a-z]{1,30}"
        let userTest = NSPredicate(format: "SELF MATCHES %@", userNameRegEx)
        return userTest.evaluate(with: name)
    }
    */
    
    
    
}




