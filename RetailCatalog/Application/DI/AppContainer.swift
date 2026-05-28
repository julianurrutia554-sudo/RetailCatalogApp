//
//  AppContainer.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

import FactoryKit

extension Container {
    
    // MARK: - Capa de Infraestructura (Instancias Únicas / Singletons)
    var dataTransferService: Factory<DataTransferServiceProtocol> {
        self { DataTransferService() }.singleton
    }
    
    var coreDataStorage: Factory<CoreDataStorageProtocol> {
        self { CoreDataStorage.shared }.singleton
    }
    
    var keychainStorage: Factory<KeychainStorageProtocol> {
        self { KeychainStorage() }.singleton
    }
    
    // MARK: - Capa de Datos (Data)
    // El repositorio recibe la infraestructura de red y de persistencia local
    var productsRepository: Factory<ProductsRepositoryProtocol> {
        self {
            DefaultProductsRepository(
                networkService: self.dataTransferService(),
                cacheStorage: self.coreDataStorage()
            )
        }
    }
    
    // MARK: - Capa de Dominio (Domain)
    var fetchProductsUseCase: Factory<FetchProductsUseCase> {
        self { FetchProductsUseCase(repository: self.productsRepository()) }
    }
    
    // MARK: - Capa de Presentación (Presentation)
    var productListViewModel: Factory<ProductListViewModel> {
        self { ProductListViewModel(fetchProductsUseCase: self.fetchProductsUseCase()) }
    }
}
