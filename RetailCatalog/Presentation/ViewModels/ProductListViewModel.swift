//
//  ProductListViewModel.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

enum ProductListViewModelState {
    case idle, loading, success([ProductUIModel]), error(String)
}

@MainActor
final class ProductListViewModel {
    private let fetchProductsUseCase: FetchProductsUseCase
    var onStateChange: ((ProductListViewModelState) -> Void)?
    
    private(set) var state: ProductListViewModelState = .idle {
        didSet { onStateChange?(state) }
    }
    
    init(fetchProductsUseCase: FetchProductsUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
    func loadProducts() async {
        state = .loading
        do {
            let entities = try await fetchProductsUseCase.execute()
            
            let uiModels = entities.map { entity in
                let priceDisplay = entity.price == 0 ? "Gratis" : String(format: "%.2f €", entity.price)
                let badge = entity.id.contains("ZARA") ? "¡Tendencia!" : nil
                
                return ProductUIModel(
                    id: entity.id,
                    title: entity.name.uppercased(),
                    formattedPrice: priceDisplay,
                    badgeText: badge,
                    imageUrl: entity.imageUrl
                )
            }
            state = .success(uiModels)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
