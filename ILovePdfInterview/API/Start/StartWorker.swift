//
//  StartRouter.swift
//  ILovePdfInterview
//
//  Created by usuario on 5/1/21.
//

import Foundation
import UIKit

protocol StartWorkerProtocol: BaseWorkerProtocol {
    func startSuccess(response: StartTaskResponse)
}

class StartWorker: BaseWorker{
    
    var delegate: StartWorkerProtocol?
    
    let baseStartUrl = "https://api.ilovepdf.com/v1/start/"
    
    func startCall(delegate: StartWorkerProtocol, token: String){
        self.delegate = delegate
        crearLlamada(method: .get,
                     url: "\(baseStartUrl)\(TaskFlowManager.shared.herramienta?.getUrl() ?? "")",
                     respuesta: StartTaskResponse(server: "", task: ""),
                     errorRespuesta: AuthenticationErrorResponse(),
                     bearer: token){ (result, error) in
            guard let respuesta = result else {
                self.delegate?.showError(error: error!)
                return
            }
            self.delegate?.startSuccess(response: respuesta)
        }
    }
    
}


