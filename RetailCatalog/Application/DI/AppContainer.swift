//
//  AppContainer.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

import FactoryKit

extension Container {
    
    // MARK: - Infraestructure
    var apiClient: Factory<APIClientProtocol> {
        self { APIClient() }.singleton
    }
    
    var dataTransferService: Factory<DataTransferServiceProtocol> {
        self { DataTransferService(apiClient: self.apiClient()) }.singleton
    }
    
    var coreDataStorage: Factory<CoreDataStorageProtocol> {
        self { CoreDataStorage.shared }.singleton
    }
    
    var keychainStorage: Factory<KeychainStorageProtocol> {
        self { KeychainStorage() }.singleton
    }
    
    // MARK: - Data
    var productsRepository: Factory<ProductsRepositoryProtocol> {
        self {
            DefaultProductsRepository(
                networkService: self.dataTransferService(),
                cacheStorage: self.coreDataStorage()
            )
        }
    }
    
    // MARK: - Domain
    var fetchProductsUseCase: Factory<FetchProductsUseCase> {
        self { FetchProductsUseCase(repository: self.productsRepository()) }
    }
    
    // MARK: - Presentation
    @MainActor
    var productListViewModel: Factory<ProductListViewModel> {
        self { ProductListViewModel(fetchProductsUseCase: self.fetchProductsUseCase()) }
    }
}
