//
//  AuthenticationInteractor.swift
//  ILovePdfInterview
//
//  Created by usuario on 6/1/21.
//

import Foundation
import UIKit

protocol AuthenticationInteractorProtocol {
    func tokenSuccess(token: String)
    func showError(error: ILPDFError)
}

class AuthenticationInteractor{
    
    var delegate: AuthenticationInteractorProtocol?
    
    func getToken(delegate: AuthenticationInteractorProtocol, invalidateCache: Bool = false){
        self.delegate = delegate
        if isTokenValid() && !invalidateCache{
            self.delegate?.tokenSuccess(token: UserDefaults.standard.string(forKey: "token") ?? "")
        } else {
            AuthenticationWorker().tokenCall(delegate: self)
        }
    }
    
    private func isTokenValid() -> Bool{
        guard let expirationdate = UserDefaults.standard.object(forKey: "token_expiration") as? Date else{
            return false
        }
        return expirationdate > Date()
    }
    
    private func saveToken(token: String){
        UserDefaults.standard.set(token, forKey: "token")
        /*
         In the Api Documentation its said that token expires in 2 hours
         It would be great if the backend could give us the expiration date of the token for futures variations
         */
        let calendar = Calendar.current
        let expirationDate = calendar.date(byAdding: .hour, value: 2, to: Date())
        
        UserDefaults.standard.set(expirationDate, forKey: "token_expiration")
    }
    
}

extension AuthenticationInteractor: AuthenticationWorkerProtocol{
    func getTokenSuccess(token: String) {
        saveToken(token: token)//the new token is saved
        delegate?.tokenSuccess(token: token)
    }
    
    func showError(error: ILPDFError) {
        delegate?.showError(error: error)
    }
}

struct AuthenticationResponse: Codable{
    var token: String
}

struct AuthenticationErrorResponse: Codable{
    var name: String = ""
    var message: String = ""
    var code: Int = 0
    var status: Int = 0
}
