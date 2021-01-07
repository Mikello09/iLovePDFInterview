//
//  CompresionItemCell.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit

protocol CompresionItemCellProtocol {
    func compresionSeleccionado(index: Int)
}

class CompresionItemCell: UITableViewCell{
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var subtitulo: UILabel!
    @IBOutlet weak var seleccionadoImagen: UIImageView!
    
    
    var index: Int?
    var delegate: CompresionItemCellProtocol?
    
    func configure(compresion: TipoCompresion, seleccionado: Bool, index: Int, delegate: CompresionItemCellProtocol){
        self.index = index
        self.delegate = delegate
        
        titulo.text = compresion.getTitulo()
        subtitulo.text = compresion.getSubtitulo()
        
        seleccionadoImagen.isHidden = !seleccionado
        container.backgroundColor = seleccionado ? .GrisTransparente : .clear
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(compresionItemSelected))
        container.isUserInteractionEnabled = true
        container.addGestureRecognizer(tap)
    }
    
    @objc
    func compresionItemSelected(){
        if let indice = index{
            self.delegate?.compresionSeleccionado(index: indice)
        }
    }
}
