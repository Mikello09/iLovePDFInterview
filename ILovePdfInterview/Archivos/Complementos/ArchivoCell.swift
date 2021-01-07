//
//  ArchivoCell.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit

protocol ArchivoCellProtocol {
    func archivoCellSelected(file: LocalFile)
}

class ArchivoCell: UITableViewCell{
    
    @IBOutlet weak var fileItem: FileItemView!
    var file: LocalFile?
    var delegate: ArchivoCellProtocol?
    
    
    func configure(file: LocalFile, delegate: ArchivoCellProtocol){
        self.file = file
        self.delegate = delegate
        fileItem.configure(titulo: file.titulo,
                           detalles: file.detalles,
                           imagen: file.miniatura,
                           delegate: self)
    }
}

extension ArchivoCell: FileItemViewProtocol{
    func fileSelected() {
        if let fichero = self.file{
            self.delegate?.archivoCellSelected(file: fichero)
        }
    }
}
