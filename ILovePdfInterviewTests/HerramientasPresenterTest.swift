//
//  HerramientasPresenterTest.swift
//  ILovePdfInterview
//
//  Created by usuario on 7/1/21.
//

import XCTest
@testable import ILovePdfInterview

class HerramientasPresenterTest: XCTestCase {

    var sut: HerramientasPresenter!
    var comprimirPdfActivo: Bool = false
    
    override func setUpWithError() throws {
        sut = HerramientasPresenter()
        sut.delegate = self
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testCompressPdfHerramientaConPDF(){
        sut.getHerramientas(fileType: .pdf)
        XCTAssert(comprimirPdfActivo, "Herramienta comprimida activa")
    }
    
    func testCompressPdfHerramientaConImage(){
        sut.getHerramientas(fileType: .image)
        XCTAssert(!comprimirPdfActivo, "Herramienta comprimida deshabilitada")
    }
}

extension HerramientasPresenterTest: HerramientasPresenterProtocol{
    func showHerramientas(herramientas: [Herramienta]) {
        let comprimirHerramienta = herramientas.filter{$0.tipo == .compress}.first
        comprimirPdfActivo = comprimirHerramienta?.habilitada ?? false
    }
}
