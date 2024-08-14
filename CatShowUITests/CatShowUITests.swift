//
//  CatShowUITests.swift
//  CatShowUITests
//
//  Created by Milton Leslie Sanches on 12/08/24.
//

import XCTest

final class CatShowUITests: XCTestCase {

    func testListToDetailNavigation() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Verifica se há células na lista
        let firstCell = app.tables.cells.element(boundBy: 0)
        
        // Adiciona uma expectativa de que a célula vai aparecer
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: firstCell, handler: nil)
        
        // Aguarda até 10 segundos para a célula aparecer
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(firstCell.exists, "The first cell should exist")
        
        // Toca na primeira célula para ir para a tela de detalhes
        firstCell.tap()
        
        // Adiciona uma expectativa de que a tela de detalhes será apresentada
        let detailView = app.otherElements["DetailView"]
        expectation(for: existsPredicate, evaluatedWith: detailView, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(detailView.exists, "The detail view should be displayed")
        
        // Adiciona uma expectativa de que a imagem na tela de detalhes será carregada
        let imageView = app.images["DetailImageView"]
        expectation(for: existsPredicate, evaluatedWith: imageView, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(imageView.exists, "The image view should be present in the detail view")
    }
}
