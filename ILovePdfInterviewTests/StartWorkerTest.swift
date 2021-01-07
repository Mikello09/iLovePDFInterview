//
//  StartWorkerTest.swift
//  ILovePdfInterviewTests
//
//  Created by usuario on 7/1/21.
//

import XCTest
@testable import Demo

class StartWorkerTest: XCTestCase {

    var sut: StartWorker!
    var resultSuccess: Bool = false
    var resultCrash: Bool = false
    
    override func setUpWithError() throws {
        sut = StartWorker()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testStartResponse(){
        sut.startCall(delegate: self, token: "")
        XCTAssert(resultSuccess, "Start worker result success")
    }

}

extension StartWorkerTest: StartWorkerProtocol{
    func startSuccess(response: StartTaskResponse) {
        resultSuccess = true
    }
    
    func showError(error: ILPDFError) {
        resultCrash = true
    }
}
