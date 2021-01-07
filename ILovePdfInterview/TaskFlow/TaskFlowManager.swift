//
//  TaskFlowManager.swift
//  ILovePdfInterview
//
//  Created by usuario on 6/1/21.
//

/*
 This is the manager of the TaskFlow. When we want to execute a task to a file, we must follow some steps. Those steps accumulate information that we would need in forward steps. For that a Singleton has ben created. Be aware of reseting values when flow is finished in order to be prepare for a new flow.
 */

import Foundation
import UIKit

protocol TaskFlowManagerProtocol {
    func error(error: ILPDFError)
    func taskSuccess(file: URL,
                     beforeSize: Int,
                     actualSize: Int)
}

class TaskFlowManager{
    
    static var shared = TaskFlowManager()
    
    var delegate: TaskFlowManagerProtocol?
    
    //User elections
    var herramienta: TipoHerramienta?
    var url: URL?
    var compresion: TipoCompresion?
    
    //Server variables
    var server: String?
    var taskID: String?
    var server_fileName: String?
    var filesize: Int?
    var output_filesize: Int?
    var originalFileName: String?
    
    func resetValues(){
        self.delegate = nil
        self.herramienta = nil
        self.url = nil
        self.compresion = nil
        self.server = nil
        self.taskID = nil
        self.server_fileName = nil
        self.filesize = nil
        self.output_filesize = nil
        self.originalFileName = nil
    }
    
    func startTaskFlow(delegate: TaskFlowManagerProtocol){
        self.delegate = delegate
        guard
            let _ = self.herramienta,
            let _ = self.url,
            let _ = self.compresion else{
                showTaskError(error: ILPDFError(message: "steps_error".localized))
                return
        }
        
        StartInteractor().startTask(delegate: self)
        
    }
    /*
     This function is executed everytime the flow crashes. Is an end of the flow. We have to check the error status in order to take next movements decissions.
     */
    func showTaskError(error: ILPDFError) {
        if error.status == 401{//New token needed
            StartInteractor().startTask(delegate: self, invalidateTokenCache: true)
        } else {
            self.delegate?.error(error: error)
            resetValues()
        }
        
    }
}
/*
 Server side task flow has 4 steps: Start, Upload, Process and Download. Each one would have its own Interactor and Worker and the TaskFlowManager would call them in order.
 */
extension TaskFlowManager: StartInteractorProtocol{
    func startSuccess(startResponse: StartTaskResponse) {
        self.server = startResponse.server
        self.taskID = startResponse.task
        UploadInteractor().uploadTask(delegate: self,
                                      server: self.server,
                                      taskID: self.taskID,
                                      url: self.url)
    }
    func showStartError(error: ILPDFError){
        self.showTaskError(error: error)
    }
    
}

extension TaskFlowManager: UploadInteracotrProtocol{
    func successUpload(respuesta: UploadRespuesta) {
        self.server_fileName = respuesta.server_filename
        self.originalFileName = self.url?.lastPathComponent
        ProcessInteractor().processTask(server: self.server ?? "",
                                        taskID: self.taskID ?? "",
                                        tool: self.herramienta?.getUrl() ?? "",
                                        server_filename: self.server_fileName ?? "",
                                        original_filename: self.originalFileName ?? "",
                                        compression_level: self.compresion?.rawValue ?? "",
                                        delegate: self)
    }
    func showUploadError(error: ILPDFError){
        self.showTaskError(error: error)
    }
}

extension TaskFlowManager: ProcessInteractorProtocol{
    func successProcess(respuesta: ProcessResponse) {
        self.filesize = respuesta.filesize
        self.output_filesize = respuesta.output_filesize
        DownloadInteractor().downloadTask(delegate: self,
                                          server: self.server ?? "",
                                          task: self.taskID ?? "")
    }
    func showProcessError(error: ILPDFError){
        self.showTaskError(error: error)
    }
}

extension TaskFlowManager: DownloadInteractorProtocol{
    func successDownload(file: URL) {
        if let data = file.getData(){
            /*
             This is de sucessful end of the flow. The file would be saved in apps directory for accesing it from Archivos.
             */
            LocalFileManager().saveFile(fileName: self.originalFileName ?? "", data: data)
            self.delegate?.taskSuccess(file: file,
                                       beforeSize: self.filesize ?? 0,
                                       actualSize: self.output_filesize ?? 0)
            resetValues()
        } else {
            self.showTaskError(error: genericError)
        }
    }
    func showDownloadError(error: ILPDFError){
        self.showTaskError(error: error)
    }
}
