//
//  BaseInteractor.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit

protocol BaseInteractorProtocol {
    func showError(error: ILPDFError)
    func tokenObtained(token: String)
}

class BaseInteractor{
    
    var baseDelegate: BaseInteractorProtocol?
    
    func getToken(delegate: BaseInteractorProtocol, invalidateTokenCache: Bool = false){
        self.baseDelegate = delegate
        AuthenticationInteractor().getToken(delegate: self,
                                            invalidateCache: invalidateTokenCache)
    }
    
    func showError(error: ILPDFError){
        baseDelegate?.showError(error: error)
    }
}

extension BaseInteractor: AuthenticationInteractorProtocol{
    func tokenSuccess(token: String) {
        self.baseDelegate?.tokenObtained(token: token)
    }
}
