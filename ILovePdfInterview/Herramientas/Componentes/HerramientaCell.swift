//
//  HerramientaCell.swift
//  ILovePdfInterview
//
//  Created by usuario on 6/1/21.
//

import Foundation
import UIKit


protocol HerramientaCellProtocol {
    func onHerramientaClicked(herramienta: Herramienta)
}

class HerramientaCell: UICollectionViewCell{
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var desabilitadoView: UIView!
    
    
    var herramienta: Herramienta?
    var delegate: HerramientaCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(herramienta: Herramienta, delegate: HerramientaCellProtocol){
        self.herramienta = herramienta
        self.delegate = delegate
        
        container.addShadowInContainerView()
        if !herramienta.habilitada{
            desabilitadoView.isHidden = false
            titulo.textColor = UIColor.Gris
        }
        titulo.text = herramienta.tipo.getTitulo()
        imagen.image = UIImage(named: herramienta.tipo.getImagen())
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCellClicked))
        container.isUserInteractionEnabled = true
        container.addGestureRecognizer(tap)
        
    }
    
    @objc
    func onCellClicked(){
        if let herramienta = herramienta, herramienta.habilitada{
            delegate?.onHerramientaClicked(herramienta: herramienta)
        }
    }
    
}
