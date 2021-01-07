//
//  StartWorkerDemo.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit


protocol StartWorkerProtocol: BaseWorkerProtocol {
    func startSuccess(response: StartTaskResponse)
}

class StartWorker: BaseWorker{
    
    var delegate: StartWorkerProtocol?
    
    let startSuccessResponse: [String: String] = [
        "server": "AAA",
        "task": "bbb"
    ]
    
    func startCall(delegate: StartWorkerProtocol, token: String){
        self.delegate = delegate
        do{
            let responseData = try newJSONEncoder().encode(startSuccessResponse)
            let result = try newJSONDecoder().decode(StartTaskResponse.self, from: responseData)
            self.delegate?.startSuccess(response: result)
        }catch{
            self.delegate?.showError(error: genericError)
        }
    }
    
}
