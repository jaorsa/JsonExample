import Foundation
import UIKit

protocol PlantingCellDelegate{
    func segueApplications(cell: PlantingCell)
}

class PlantingCell: UITableViewCell{
    var delegate: PlantingCellDelegate?
    
    let estadosalud = ["", "Saludable", "Enfermo"]
    
    var siembra: planting? {
        didSet{
            //BedLabel.text = "Cultivo: " +
                BornLabel.text =  "Salud: " + estadosalud[siembra!.salud]
            
        }
    }
    
    var cultivo: Crop? {
        didSet{
            BedLabel.text = "Cultivo: " + (cultivo!.name)
        }
    }
    
    let BedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.text = "etiqueta"
        label.textColor = UIColor(named: "Lime")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let BornLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 13)
        label.textColor = .white
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ApplicationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Aplicaciones", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(named: "Lime")
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(BedLabel)
        BedLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10,paddingLeft: 10 ,paddingBottom: 0,paddingRight: 0, width: 200, height: 30)
        
        addSubview(ApplicationButton)
        ApplicationButton.anchor(top: topAnchor, left: BedLabel.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 10, height: 38)
        ApplicationButton.addTarget(self, action: #selector(application), for: .touchUpInside)
        
        addSubview(BornLabel)
        BornLabel.anchor(top: BedLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 3,paddingLeft: 20 ,paddingBottom: 0,paddingRight: 10, height: 15)
        backgroundColor = UIColor(named: "Grass")
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func application(){
        delegate?.segueApplications(cell: self)
    }
}
