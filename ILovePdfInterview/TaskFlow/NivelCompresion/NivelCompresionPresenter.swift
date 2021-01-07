//
//  NivelCompresionPresenter.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit

struct Compresion{
    var tipo: TipoCompresion
    var seleccionado: Bool
}

enum TipoCompresion: String {
    case extrema = "extreme"
    case recomendada = "recommended"
    case baja = "low"
    
    func getTitulo() -> String{
        switch self {
        case .extrema:
            return "extremaTitulo".localized
        case .recomendada:
            return "recomendadTitulo".localized
        case .baja:
            return "bajaTitulo".localized
        }
    }
    
    func getSubtitulo() -> String{
        switch self {
        case .extrema:
            return "extremaSubtitulo".localized
        case .recomendada:
            return "recomendadaSubtitulo".localized
        case .baja:
            return "bajaSubtitulo".localized
        }
    }
}

protocol NivelCompresionPresenterProtocol{
    func showCompresiones(compresiones: [Compresion])
}

class NivelCompresionPresenter{
    
    var delegate: NivelCompresionPresenterProtocol?
    
    var compresiones = [Compresion(tipo: .extrema, seleccionado: false),
                        Compresion(tipo: .recomendada, seleccionado: true),//default value
                        Compresion(tipo: .baja, seleccionado: false)]
    
    /*
     All the compression are setted and a default value is added
     */
    func getCompresiones(){
        TaskFlowManager.shared.compresion = .recomendada// default value
        delegate?.showCompresiones(compresiones: compresiones)
    }
    
    func compresionSeleccionado(indice: Int){
        compresiones = compresiones.enumerated().map({ (index, compresion) -> Compresion in
            return Compresion(tipo: compresion.tipo, seleccionado: index == indice)
        })
        /*
         TaskFlow compresion level is updated everytime compression level is changed
         */
        TaskFlowManager.shared.compresion = compresiones[indice].tipo
        delegate?.showCompresiones(compresiones: compresiones)
    }
    
}
