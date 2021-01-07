//
//  HerramientasPresenter.swift
//  ILovePdfInterview
//
//  Created by usuario on 6/1/21.
//

import Foundation
import UIKit

struct Herramienta{
    var tipo: TipoHerramienta
    var habilitada: Bool
}

//Enum with all the Herramientas available. Also giving its title, image and tool url
enum TipoHerramienta {
    case compress
    case divide
    
    func getTitulo() -> String{
        switch self{
            case .compress: return "comprimir".localized
            case .divide: return "dividir".localized
        }
    }
    
    func getImagen() -> String{
        switch self {
            case .compress: return "compress_icon"
            case .divide: return ""
        }
    }
    
    func getUrl() -> String{
        switch self {
        case .compress: return "compress"
        case .divide: return "split"
        }
    }
}

//Enum with all of file types available
enum FileType{
    case pdf
    case image
}

protocol HerramientasPresenterProtocol {
    func showHerramientas(herramientas: [Herramienta])
}

class HerramientasPresenter{
    
    var delegate: HerramientasPresenterProtocol?
    
    var herramientas: [Herramienta] = []
    
    /*
     This function would vary whith different types of Herramientas, some available for the file type and others not
     */
    func getHerramientas(fileType: FileType){
        herramientas = [
            Herramienta(tipo: .compress, habilitada: fileType == .pdf)]
        delegate?.showHerramientas(herramientas: herramientas)
    }
    
}
