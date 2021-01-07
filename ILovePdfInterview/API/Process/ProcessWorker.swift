//
//  ProcessRouter.swift
//  ILovePdfInterview
//
//  Created by usuario on 5/1/21.
//

import Foundation
import UIKit

protocol ProcessWorkerProtocol: BaseWorkerProtocol {
    func successProcessCall(respuesta: ProcessResponse)
}

class ProcessWorker: BaseWorker{
    
    var delegate: ProcessWorkerProtocol?
    
    let baseProcessUrl = "/v1/process"
    
    func processCall(token: String,
                     server: String,
                     taskID: String,
                     tool: String,
                     server_filename: String,
                     original_filename: String,
                     compression_level: String,
                     delegate: ProcessWorkerProtocol){
        self.delegate = delegate
        crearLlamada(method: .post,
                     url: "https://\(server)\(baseProcessUrl)",
                     respuesta: ProcessResponse(),
                     errorRespuesta: AuthenticationErrorResponse(),
                     params: [
                        "task": taskID,
                        "tool": tool,
                        "files": [["server_filename":server_filename,"filename":original_filename]],
                        "compression_level": compression_level
                     ],
                     bearer: token){ (result, error) in
                        guard let respuesta = result else {
                            self.delegate?.showError(error: error!)
                            return
                        }
                        self.delegate?.successProcessCall(respuesta: respuesta)
        }
        
        
    }
    
}

