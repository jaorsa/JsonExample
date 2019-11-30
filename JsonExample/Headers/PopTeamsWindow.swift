//
//  PopTeamsWindow.swift
//  JsonExample
//
//  Created by Administrador on 27/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import Foundation
import UIKit

protocol PopUpDelegate {
    func handleDismissal()
}


private let reuseIdentifier = "TeamsCell"
class PopTeamsWindow: UIView{
    var tableView: UITableView!
    var delegate: PopUpDelegate?
    
    
    let topLabel: UILabel = {
       let label = UILabel()
        label.text = "EQUIPOS"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("CANCELAR", for: .normal)
        button.backgroundColor = UIColor(named: "Lime")
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        //button.addTarget(self, action: #selector(login), for: .touchUpInside)
        button.layer.cornerRadius = 5
       
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "Lime")
        layer.borderWidth = 3
        layer.borderColor = UIColor.white.cgColor
        configureTableView()
        addSubview(closeButton)
        closeButton.anchor(top: tableView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)//, width: <#T##CGFloat?#>, height: <#T##CGFloat?#>)
        closeButton.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
       tableView.register(TeamsCell.self, forCellReuseIdentifier: "TeamsCell")
        addSubview(topLabel)
        topLabel.anchor(top: topAnchor,  bottom: nil, paddingTop: 5, paddingBottom: 0,  height: 30)
        topLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(tableView)
        tableView.anchor(top: topLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 225)
    }
    
    
    @objc func handleDismissal(){
        delegate?.handleDismissal()
    }
}
extension PopTeamsWindow: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return equipos?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TeamsCell
        //cell.deleg = self
        cell.team = equipos?[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        teamid = equipos?[indexPath.row].id
        handleDismissal()
        print(teamid)
    }
}
