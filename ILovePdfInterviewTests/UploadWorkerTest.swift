//
//  UploadWorkerTest.swift
//  ILovePdfInterviewTests
//
//  Created by usuario on 7/1/21.
//

import XCTest
@testable import Demo

class UploadWorkerTest: XCTestCase {

    var sut: UploadWorker!
    var resultSuccess: Bool = false
    var resultCrash: Bool = false
    
    override func setUpWithError() throws {
        sut = UploadWorker()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testUploadResultSuccess(){
        sut.uploadCall(delegate: self,
                       token: "",
                       server: "",
                       taskID: "",
                       file: nil)
        XCTAssert(resultSuccess, "Upload result success")
    }

}

extension UploadWorkerTest: UploadWorkerProtocol{
    func uploadSuccess(respuesta: UploadRespuesta) {
        resultSuccess = true
    }
    
    func showError(error: ILPDFError) {
        resultCrash = true
    }
    
    
}
