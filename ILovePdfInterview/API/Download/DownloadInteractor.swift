//
//  DownloadInteractor.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit

protocol DownloadInteractorProtocol {
    func showDownloadError(error: ILPDFError)
    func successDownload(file: URL)
}

class DownloadInteractor: BaseInteractorProtocol{
    
    var delegate: DownloadInteractorProtocol?
    var server: String?
    var taskID: String?
    
    func downloadTask(delegate: DownloadInteractorProtocol,
                      server: String,
                      task: String){
        self.delegate = delegate
        self.server = server
        self.taskID = task
        BaseInteractor().getToken(delegate: self)
    }
    
    func showError(error: ILPDFError) {
        self.delegate?.showDownloadError(error: error)
    }
    
    func tokenObtained(token: String) {
        DownloadWorker().downloadCall(server: self.server ?? "",
                                      taskID: self.taskID ?? "",
                                      token: token,
                                      delegate: self)
    }
}

extension DownloadInteractor: DownloadWorkerProtocol{
    func successDownloadFile(file: URL) {
        self.delegate?.successDownload(file: file)
    }
}
