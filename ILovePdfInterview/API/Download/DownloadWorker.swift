//
//  DownloadWorker.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit

protocol DownloadWorkerProtocol {
    func showError(error: ILPDFError)
    func successDownloadFile(file: URL)
}

class DownloadWorker: BaseWorker{
    
    var delegate: DownloadWorkerProtocol?
    
    let baseDownloadUrl = "/v1/download/"
    
    func downloadCall(server: String,
                      taskID: String,
                      token: String,
                      delegate: DownloadWorkerProtocol){
        self.delegate = delegate
        
        
        crearDownloadLlamada(url: "https://\(server)\(baseDownloadUrl)\(taskID)",
                             token: token){ (result,error) in
            guard let file = result else {
                self.delegate?.showError(error: error!)
                return
            }
            self.delegate?.successDownloadFile(file: file)
        }
    }
    
}
