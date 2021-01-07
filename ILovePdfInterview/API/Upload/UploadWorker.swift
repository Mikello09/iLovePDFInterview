//
//  UploadRouter.swift
//  ILovePdfInterview
//
//  Created by usuario on 5/1/21.
//

import Foundation
import UIKit


protocol UploadWorkerProtocol: BaseWorkerProtocol {
    func uploadSuccess(respuesta: UploadRespuesta)
}

class UploadWorker: BaseWorker{
    
    var delegate: UploadWorkerProtocol?
    
    let baseUploadUrl = "/v1/upload"
    
    func uploadCall(delegate: UploadWorkerProtocol, token: String, server: String, taskID: String, file: URL?){
        guard let fichero = file else {
            return
        }
        self.delegate = delegate
        crearLlamada(method: .post,
                     url: "https://\(server)\(baseUploadUrl)",
                     respuesta: UploadRespuesta(server_filename: ""),
                     errorRespuesta: AuthenticationErrorResponse(),
                     params: ["task": taskID],
                     uploadFile: fichero,
                     bearer: token){ (result, error) in
            guard let respuesta = result else {
                self.delegate?.showError(error: error!)
                return
            }
            self.delegate?.uploadSuccess(respuesta: respuesta)
        }
    }
    
}


