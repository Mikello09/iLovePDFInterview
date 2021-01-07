//
//  NivelCompresionPresenterTest.swift
//  ILovePdfInterviewTests
//
//  Created by usuario on 7/1/21.
//

import XCTest
@testable import ILovePdfInterview

class NivelCompresionPresenterTest: XCTestCase {

    var sut: NivelCompresionPresenter!
    var nivelCompresionSeleccionado: Compresion?
    
    override func setUpWithError() throws {
        sut = NivelCompresionPresenter()
        sut.delegate = self
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testDefaultCompresion(){
        sut.getCompresiones()
        XCTAssert(nivelCompresionSeleccionado?.tipo == .recomendada, "Compresion por defecto: Recomendada")
    }
    
    func testCompresionExtremaSeleccionado(){
        sut.compresionSeleccionado(indice: 0)
        XCTAssert(nivelCompresionSeleccionado?.tipo == .extrema, "Compresion: Extrema")
    }
    
    func testCompresionRecomendadaSeleccionado(){
        sut.compresionSeleccionado(indice: 1)
        XCTAssert(nivelCompresionSeleccionado?.tipo == .recomendada, "Compresion: Recomendada")
    }
    
    func testCompresionBajaSeleccionado(){
        sut.compresionSeleccionado(indice: 2)
        XCTAssert(nivelCompresionSeleccionado?.tipo == .baja, "Compresion: Baja")
    }
}

extension NivelCompresionPresenterTest: NivelCompresionPresenterProtocol{
    func showCompresiones(compresiones: [Compresion]) {
        nivelCompresionSeleccionado = compresiones.filter{$0.seleccionado}.first
    }
}
