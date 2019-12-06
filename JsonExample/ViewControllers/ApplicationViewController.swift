//
//  ApplicationViewController.swift
//  JsonExample
//
//  Created by Administrador on 04/12/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "ApplicationCell"

class ApplicationViewController: UIViewController{
    var resources = [Resource]()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(ApplicationCell.self, forCellReuseIdentifier: reuseIdentifier)
        table.rowHeight = 65
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 5, paddingBottom: 0, paddingRight: 5)
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.backgroundColor = .clear
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        load()
    }
    
    func load(){
        //if aplicaciones != nil{
                //if (aplicaciones!.count)>=1{
                    //for i in 0...aplicaciones!.count-1{
                        sharedResourceInstance.getRequest(url: "http://granjapp2.appspot.com/resources"){(str,recurso, error) in
                            if error == nil{
                                DispatchQueue.main.async {
                                    recursos = recurso
                                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ApplicationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recursos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ApplicationCell
        cell.recurso = recursos?[indexPath.row]
        //cell.aplicacion = aplicaciones?[indexPath.row]
        //cell.delegate = self
        return cell
    }
    
    
}
