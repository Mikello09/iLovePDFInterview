//
//  ArchivosPresenter.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit


struct LocalFile{
    var url: URL
    var miniatura: UIImage?
    var titulo: String
    var detalles: String
}

protocol ArchivosPresenterProtocol {
    func showEmpty()
    func showFiles(files: [LocalFile])
}

class ArchivosPresenter{
    
    var delegate: ArchivosPresenterProtocol?
    var archivosLocales: [LocalFile] = []
    
    func getLocalFiles(){
        archivosLocales = []//reset this var for avoid accumulations
        let ficherosLocales = LocalFileManager().getAllFiles()
        if ficherosLocales.count == 0 {
            delegate?.showEmpty()
        } else {
            for file in ficherosLocales{
                archivosLocales.append(LocalFile(url: file,
                                                 miniatura: file.getMiniatura(),
                                                 titulo: file.getTitle(),
                                                 detalles: file.getFileDetails()))
            }
            delegate?.showFiles(files: archivosLocales)
        }
    }
    
}
