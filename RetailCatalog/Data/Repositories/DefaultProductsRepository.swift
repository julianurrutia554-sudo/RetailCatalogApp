//
//  DefaultProductsRepository.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

import Foundation

final class DefaultProductsRepository: ProductsRepositoryProtocol {
    private let networkService: DataTransferServiceProtocol
    private let cacheStorage: CoreDataStorageProtocol
    
    init(networkService: DataTransferServiceProtocol, cacheStorage: CoreDataStorageProtocol) {
        self.networkService = networkService
        self.cacheStorage = cacheStorage
    }
    
    func getProducts() async throws -> [Product] {
        do {
            let dtos: [ProductDTO] = try await networkService.request(with: RetailAPI.getProducts())
            return dtos.map { ProductMapper.toDomain(dto: $0) }
        } catch {
            #if DEBUG
            print("⚠️ Caída de red. Usando contingencia local.")
            #endif
            return [
                Product(id: "MOCK-01", name: "Chaqueta Denim Local", price: 49.99, imageUrl: "")
            ]
        }
    }
}
