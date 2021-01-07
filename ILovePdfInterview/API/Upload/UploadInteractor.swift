//
//  UploadInteractor.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit

protocol UploadInteracotrProtocol {
    func successUpload(respuesta: UploadRespuesta)
    func showUploadError(error: ILPDFError)
}

class UploadInteractor: BaseInteractorProtocol{
    
    var delegate: UploadInteracotrProtocol?
    var server: String?
    var taskID: String?
    var url: URL?
    
    func uploadTask(delegate: UploadInteracotrProtocol, server: String?, taskID: String?, url: URL?){
        self.delegate = delegate
        self.server = server
        self.taskID = taskID
        self.url = url
        BaseInteractor().getToken(delegate: self)
    }
    
    func tokenObtained(token: String) {
        guard
            let url = self.url else {
                delegate?.showUploadError(error: genericError)
                return
        }
        UploadWorker().uploadCall(delegate: self,
                                  token: token,
                                  server: self.server ?? "",
                                  taskID: self.taskID ?? "",
                                  file: url)
        
    }
    
    func showError(error: ILPDFError) {
        self.delegate?.showUploadError(error: error)
    }
    
}

extension UploadInteractor: UploadWorkerProtocol{
    func uploadSuccess(respuesta: UploadRespuesta) {
        self.delegate?.successUpload(respuesta: respuesta)
    }
}

struct UploadRespuesta: Codable{
    var server_filename: String
}
