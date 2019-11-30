
import Foundation
import UIKit

class TeamsCell: UITableViewCell {
    
    var team: Equipos?{
        didSet{
            TeamLabel.text = team?.name
        }
    }
    
    let TeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.text = "etiqueta"
        return label
    }()
    
    let RolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        label.text = "etiqueta"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(TeamLabel)
        TeamLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10 ,paddingLeft: 10 ,paddingBottom: 0,paddingRight: 10, height: 20)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
