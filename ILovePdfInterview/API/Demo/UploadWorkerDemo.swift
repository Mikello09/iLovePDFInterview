//
//  UploadWorkerDemo.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit


protocol UploadWorkerProtocol: BaseWorkerProtocol {
    func uploadSuccess(respuesta: UploadRespuesta)
}

class UploadWorker: BaseWorker{
    
    var delegate: UploadWorkerProtocol?
    
    let uploadResultSuccess: [String: String] = [
        "server_filename":"AAA"
    ]
    
    func uploadCall(delegate: UploadWorkerProtocol, token: String, server: String, taskID: String, file: URL?){
        self.delegate = delegate
        do{
            let responseData = try newJSONEncoder().encode(uploadResultSuccess)
            let result = try newJSONDecoder().decode(UploadRespuesta.self, from: responseData)
            self.delegate?.uploadSuccess(respuesta: result)
        }catch{
            self.delegate?.showError(error: genericError)
        }
    }
    
    
}
