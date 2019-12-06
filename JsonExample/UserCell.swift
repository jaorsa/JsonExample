import Foundation
import UIKit

protocol UserCellDelegate {
    func joinTeam(cell:UserCell)
}



class UserCell: UITableViewCell{
    var delegate: UserCellDelegate?
    
    var team: Teams?{
        didSet{
            TeamLabel.text = team?.name
        }
    }
    
    let TeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.textColor = UIColor(named: "Lime")
        label.text = "etiqueta"
        return label
    }()
    
    lazy var JoinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Unirse", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(named: "Lime")
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(TeamLabel)
        TeamLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 22 ,paddingLeft: 15 ,paddingBottom: 0,paddingRight: 0,width: 200, height: 20)
        addSubview(JoinButton)
        JoinButton.anchor(top: topAnchor, left: TeamLabel.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 10, height: 38)
        JoinButton.addTarget(self, action: #selector(unirse), for: .touchUpInside)
        backgroundColor = UIColor(named: "Grass")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func unirse(){
        print("unido")
        delegate?.joinTeam(cell: self)
    }
}

