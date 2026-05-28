//
//  ProductsRepositoryMock.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

import Foundation
@testable import RetailCatalog

final class ProductsRepositoryMock: ProductsRepositoryProtocol {
    var resultToBeReturned: Result<[Product], Error> = .success([])
    var isGetProductsCalled = false
    var getProductsCalledCount = 0
    
    func getProducts() async throws -> [Product] {
        isGetProductsCalled = true
        getProductsCalledCount += 1
        
        switch resultToBeReturned {
        case .success(let products):
            return products
        case .failure(let error):
            throw error
        }
    }
}
