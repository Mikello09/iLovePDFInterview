//
//  ProcessInteractor.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import Foundation
import UIKit

protocol ProcessInteractorProtocol {
    func successProcess(respuesta: ProcessResponse)
    func showProcessError(error: ILPDFError)
}

class ProcessInteractor: BaseInteractorProtocol{
    
    var delegate: ProcessInteractorProtocol?
    
    var server: String?
    var taskID: String?
    var tool: String?
    var server_filename: String?
    var original_filename: String?
    var compression_level: String?
    
    func processTask(server: String,
                     taskID: String,
                     tool: String,
                     server_filename: String,
                     original_filename: String,
                     compression_level: String,
                     delegate: ProcessInteractorProtocol){
        self.delegate = delegate
        self.server = server
        self.taskID = taskID
        self.tool = tool
        self.server_filename = server_filename
        self.original_filename = original_filename
        self.compression_level = compression_level
        BaseInteractor().getToken(delegate: self)
    }
    
    func tokenObtained(token: String) {
        ProcessWorker().processCall(token: token,
                                    server: self.server ?? "",
                                    taskID: self.taskID ?? "",
                                    tool: self.tool ?? "",
                                    server_filename: self.server_filename ?? "",
                                    original_filename: self.original_filename ?? "",
                                    compression_level: self.compression_level ?? "",
                                    delegate: self)
    }
    
    func showError(error: ILPDFError) {
        self.delegate?.showProcessError(error: error)
    }
    
}

extension ProcessInteractor: ProcessWorkerProtocol{
    func successProcessCall(respuesta: ProcessResponse){
        self.delegate?.successProcess(respuesta: respuesta)
    }
}

struct ProcessResponse: Codable{
    var timer: String = ""
    var output_filesize: Int = 0
    var download_filename: String = ""
    var filesize: Int = 0
    var status: String = ""
    var output_filenumber: Int = 0
    var output_extensions: String = ""
}

struct ProcessErrorModel: Codable{
    var error: ProcessError
}

struct ProcessError: Codable{
    var type: String
    var message: String
    var code: Int
    var param: [ErrorParams]
}

struct ErrorParams: Codable{
    var server_filename: String
    var error: String
}

