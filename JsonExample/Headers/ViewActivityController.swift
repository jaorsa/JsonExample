//
//  ViewActivityController.swift
//  TextField
//
//  Created by Administrador on 06/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit



let activityName: UILabel? = {
       let label = UILabel()
       label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
       label.text = ""
       label.textColor = UIColor.white
       //label.layer.borderColor = UIColor.white.cgColor
       //label.layer.borderWidth = 3
       return label
   }()
   
  let activityDescription: UILabel? = {
       let label = UILabel()
       label.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
       label.text = ""
       label.textColor = UIColor.lightGray
       label.layer.borderColor = UIColor.white.cgColor
       label.layer.borderWidth = 2
       return label
   }()
   
   let activityComplexity: UILabel? = {
       let label = UILabel()
       label.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
       label.text = ""
       label.textColor = UIColor.white
       label.layer.borderColor = UIColor.white.cgColor
       label.layer.borderWidth = 3
       return label
   }()

class ViewActivityController: UIViewController{
    
    var activity: Activities?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Grass")
        configureView()
        setInitialValues()
        
    }
    
    func configureView(){
        view.addSubview(activityName!)
        activityName?.anchor(top: view.topAnchor, bottom: nil, paddingTop: 50, paddingBottom: 0, width: 275, height: 100)
        activityName?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(activityDescription!)
        activityDescription!.anchor(top: activityName?.bottomAnchor, bottom: nil, paddingTop: 50, paddingBottom: 0, width: 275, height: 200)
        activityDescription!.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    func setInitialValues(){
        activityName!.text = activity?.name
        activityDescription!.text = activity?.descripcion
        //activityComplexity?.text = activity?.complexity
    }
    
}
