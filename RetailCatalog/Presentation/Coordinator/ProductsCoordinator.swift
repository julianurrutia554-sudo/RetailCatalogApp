//
//  ProductsCoordinator.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

import UIKit
import FactoryKit

@MainActor
final class ProductsCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = Container.shared.productListViewModel()
        let viewController = ProductListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
