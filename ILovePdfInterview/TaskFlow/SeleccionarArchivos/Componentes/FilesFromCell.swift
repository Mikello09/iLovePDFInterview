//
//  FilesFromCell.swift
//  ILovePdfInterview
//
//  Created by usuario on 6/1/21.
//

import Foundation
import UIKit


protocol FilesFromCellProtocol {
    func fromFileClicked(from: FilesFrom)
}

class FilesFromCell: UICollectionViewCell{
    
    var fromFile: FilesFrom?
    var delegate: FilesFromCellProtocol?
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(fromFile: FilesFrom, delegate: FilesFromCellProtocol){
        self.fromFile = fromFile
        self.delegate = delegate
        
        titulo.text = fromFile.getTitulo()
        imagen.image = UIImage(systemName: fromFile.getImage())
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(fromFileClicked))
        container.isUserInteractionEnabled = true
        container.addGestureRecognizer(tap)
        
    }
    
    @objc
    func fromFileClicked(){
        if let from = fromFile{
            delegate?.fromFileClicked(from: from)
        }
    }
    
}
