//
//  AuthenticationInteractorTest.swift
//  ILovePdfInterviewTests
//
//  Created by usuario on 7/1/21.
//

import XCTest
@testable import Demo

class AuthenticationWorkerTest: XCTestCase {

    var sut: AuthenticationWorker!
    
    var resultSuccess: Bool = false
    var resultCrash: Bool = false
    
    override func setUpWithError() throws {
        sut = AuthenticationWorker()
        sut.delegate = self
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testAuthenticationResponse(){
        sut.tokenCall(delegate: self)
        XCTAssert(resultSuccess, "Authentication result success")
    }
}

extension AuthenticationWorkerTest: AuthenticationWorkerProtocol{
    func getTokenSuccess(token: String) {
        resultSuccess = true
    }
    
    func showError(error: ILPDFError) {
        resultCrash = true
    }
}
