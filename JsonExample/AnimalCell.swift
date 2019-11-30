import Foundation
import UIKit

class AnimalCell: UITableViewCell{
    var animal: Animal? {
        didSet{
            BedLabel.text = "Camada: " + animal!.name
            BornLabel.text = " Fecha de Nacimiento: " + "\(animal!.fechaNacimiento!)"
            
        }
    }
    
    let BedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.text = "etiqueta"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let BornLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Default", size: 5)
        label.textColor = UIColor.lightGray
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(BedLabel)
        BedLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10,paddingLeft: 10 ,paddingBottom: 0,paddingRight: 0, height: 30)
        
        addSubview(BornLabel)
        BornLabel.anchor(top: BedLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 3,paddingLeft: 20 ,paddingBottom: 0,paddingRight: 10, height: 15)
        
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
