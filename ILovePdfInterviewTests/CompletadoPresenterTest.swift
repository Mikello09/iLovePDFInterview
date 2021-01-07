//
//  CompletadoPresenterTest.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import XCTest
@testable import ILovePdfInterview

class CompletadoPresenterTest: XCTestCase {

    var sut: CompletadoPresenter!
    
    override func setUpWithError() throws {
        sut = CompletadoPresenter()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testPorcentaje(){
        let porcentaje = sut.getPorcentaje(before: 10, actual: 2)
        XCTAssert(porcentaje == "80.00", "Porcentaje calculado correctamente")
    }

}
