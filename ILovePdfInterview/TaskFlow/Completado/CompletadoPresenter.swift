//
//  CompletadoPresenter.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit

protocol CompletadoPresenterProtocol {
    func showCompletado(beforeSize: String, actualSize: String, percentaje: String)
    func showError(error: ILPDFError)
}

class CompletadoPresenter{
     
    var delegate: CompletadoPresenterProtocol?

    /*
     Server side TaskFlow start point
     */
    func ejecutarHerramienta(){
        TaskFlowManager.shared.startTaskFlow(delegate: self)
    }
    
    func getPorcentaje(before: Int, actual: Int) -> String{
        let percent = Double((Double(before) - Double(actual))/Double(before))*100
        return NSString(format: "%.2f", percent) as String
    }
}

extension CompletadoPresenter: TaskFlowManagerProtocol{
    func taskSuccess(file: URL,
                     beforeSize: Int,
                     actualSize: Int) {
        delegate?.showCompletado(beforeSize: beforeSize.toFileSize(),
                                 actualSize: actualSize.toFileSize(),
                                 percentaje: getPorcentaje(before: beforeSize, actual: actualSize))
    }
    
    func error(error: ILPDFError) {
        delegate?.showError(error: error)
    }
}
