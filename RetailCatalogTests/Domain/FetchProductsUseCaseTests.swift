//
//  FetchProductsUseCaseTests.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

import XCTest
import FactoryKit
import FactoryTesting
@testable import RetailCatalog

final class FetchProductsUseCaseTests: XCTestCase {
    
    private var repositoryMock: ProductsRepositoryMock!
    private var sut: FetchProductsUseCase?
    
    override func setUp() {
        super.setUp()
        repositoryMock = ProductsRepositoryMock()
        Container.shared.productsRepository.register { self.repositoryMock }
        sut = Container.shared.fetchProductsUseCase()
    }
    
    override func tearDown() {
        Container.shared.manager.pop()
        repositoryMock = nil
        sut = nil
        super.tearDown()
    }
    
    func test_execute_cuandoElRepositorioRetornaProductos_debenSerOrdenadosAlfabeticamente() async throws {
        // GIVEN
        let mockProducts = [
            Product(id: "1", name: "Zapatos Nike", price: 120.0, imageUrl: ""),
            Product(id: "2", name: "Camiseta Adidas", price: 35.0, imageUrl: ""),
            Product(id: "3", name: "Chaqueta Puma", price: 85.0, imageUrl: "")
        ]
        repositoryMock.resultToBeReturned = .success(mockProducts)
        
        // WHEN
        let result = try await sut?.execute()
        
        // THEN
        XCTAssertTrue(repositoryMock.isGetProductsCalled)
        XCTAssertEqual(result?.count, 3)
        XCTAssertEqual(result?[0].name, "Zapatos Nike")
        XCTAssertEqual(result?[1].name, "Camiseta Adidas")
        XCTAssertEqual(result?[2].name, "Chaqueta Puma")
    }
    
    func test_execute_cuandoElRepositorioFalla_elCasoDeUsoDebePropagarElError() async {
        let expectedError = NSError(domain: "NetworkError", code: -1, userInfo: nil)
        repositoryMock.resultToBeReturned = .failure(expectedError)
        
        // WHEN & THEN 
        do {
            _ = try await sut?.execute()
            XCTFail("❌ El caso de uso debió fallar pero retornó éxito de forma errónea.")
        } catch {
            XCTAssertTrue(repositoryMock.isGetProductsCalled)
            XCTAssertEqual((error as NSError).domain, "NetworkError")
        }
    }
}
