//
//  FetchProductsUseCase.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

struct FetchProductsUseCase {
    
    private let repository: ProductsRepositoryProtocol
    
    init(repository: ProductsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Product] {
        return try await repository.getProducts()
    }
}
