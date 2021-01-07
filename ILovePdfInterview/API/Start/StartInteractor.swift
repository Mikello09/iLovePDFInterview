//
//  StartInteractor.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit

protocol StartInteractorProtocol {
    func startSuccess(startResponse: StartTaskResponse)
    func showStartError(error: ILPDFError)
}

class StartInteractor: BaseInteractorProtocol{
    
    var delegate: StartInteractorProtocol?
    
    func startTask(delegate: StartInteractorProtocol, invalidateTokenCache: Bool = false){
        self.delegate = delegate
        BaseInteractor().getToken(delegate: self,
                                  invalidateTokenCache: invalidateTokenCache)
    }
    
    func tokenObtained(token: String){
        StartWorker().startCall(delegate: self,
                                token: token)
    }
    
    func showError(error: ILPDFError) {
        self.delegate?.showStartError(error: error)
    }
}

extension StartInteractor: StartWorkerProtocol{
    func startSuccess(response: StartTaskResponse) {
        self.delegate?.startSuccess(startResponse: response)
    }
}

struct StartTaskResponse: Codable{
    var server: String
    var task: String
}
