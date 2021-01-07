//
//  AuthenticationWorkerDemo.swift
//  Demo
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit

protocol AuthenticationWorkerProtocol: BaseWorkerProtocol {
    func getTokenSuccess(token: String)
}

class AuthenticationWorker: BaseWorker{
    
    var delegate: AuthenticationWorkerProtocol?
    
    let authenticationSuccessResponse : [String: String] = [
        "token": "AAAAAA"
    ]
    
    func tokenCall(delegate: AuthenticationWorkerProtocol){
        self.delegate = delegate
        do{
            let responseData = try newJSONEncoder().encode(authenticationSuccessResponse)
            let result = try newJSONDecoder().decode(AuthenticationResponse.self, from: responseData)
            self.delegate?.getTokenSuccess(token: result.token)
        }catch{
            self.delegate?.showError(error: genericError)
        }
        
    }
    
}
