//
//  ProductListViewModelTests.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

import XCTest
import FactoryKit
import FactoryTesting
@testable import RetailCatalog

final class ProductListViewModelTests: XCTestCase {
    
    private var repositoryMock: ProductsRepositoryMock!
    private var sut: ProductListViewModel!
    
    @MainActor
    override func setUp() {
        super.setUp()
        repositoryMock = ProductsRepositoryMock()
        Container.shared.productsRepository.register { self.repositoryMock }
        sut = Container.shared.productListViewModel()
    }
    
    override func tearDown() {
        Container.shared.manager.pop()
        repositoryMock = nil
        sut = nil
        super.tearDown()
    }
    
    @MainActor
    func test_loadProducts_cuandoLaCargaEsExitosa_debeActualizarElEstadoASuccessConModelosDeUIFormateados() async {
        // GIVEN
        let mockProducts = [
            Product(id: "ZARA-01", name: "Chaqueta eco", price: 49.99, imageUrl: "")
        ]
        repositoryMock.resultToBeReturned = .success(mockProducts)
        
        let expectation = expectation(description: "El ViewModel debe cambiar a estado .success")
        
        // THEN
        sut.onStateChange = { state in
            if case .success(let uiModels) = state {
                XCTAssertEqual(uiModels.count, 1)
                XCTAssertEqual(uiModels[0].title, "CHAQUETA ECO")
                XCTAssertEqual(uiModels[0].formattedPrice, "49.99 €")
                XCTAssertEqual(uiModels[0].badgeText, "¡Tendencia!")
                expectation.fulfill()
            }
        }
        
        // WHEN
        await sut.loadProducts()
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    @MainActor
    func test_loadProducts_cuandoLaCargaFalla_debeActualizarElEstadoAError() async {
        // GIVEN
        let errorSimulado = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error de servidor"])
        repositoryMock.resultToBeReturned = .failure(errorSimulado)
        
        let expectation = expectation(description: "El ViewModel debe cambiar a estado .error")
        
        // THEN
        sut.onStateChange = { state in
            if case .error(let mensaje) = state {
                XCTAssertEqual(mensaje, "Error de servidor")
                expectation.fulfill()
            }
        }
        
        // WHEN
        await sut.loadProducts()
        await fulfillment(of: [expectation], timeout: 1.0)
    }
}
