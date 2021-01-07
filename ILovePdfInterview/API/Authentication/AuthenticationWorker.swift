//
//  AuthenticationRouter.swift
//  ILovePdfInterview
//
//  Created by usuario on 5/1/21.
//

import Foundation
import UIKit


protocol AuthenticationWorkerProtocol: BaseWorkerProtocol {
    func getTokenSuccess(token: String)
}

class AuthenticationWorker: BaseWorker{
    
    let public_key = "project_public_e07c548ec12756d063bbac2a3f7e19f4_97zyS2e25e6087d91ee35e81dcdba579e3cc3"
    
    var delegate: AuthenticationWorkerProtocol?
    
    let baseAuthenticationUrl = "https://api.ilovepdf.com/v1/auth"
    
    func tokenCall(delegate: AuthenticationWorkerProtocol){
        self.delegate = delegate
        crearLlamada(method: .post,
                     url: baseAuthenticationUrl,
                     respuesta: AuthenticationResponse(token: ""),
                     errorRespuesta: AuthenticationErrorResponse(),
                     params: ["public_key":public_key]){ response,error in
            guard let authResponse = response else {
                if let error = error{
                    self.delegate?.showError(error: error)
                }
                return
            }
            self.delegate?.getTokenSuccess(token: authResponse.token)
        }
    }

    
}


