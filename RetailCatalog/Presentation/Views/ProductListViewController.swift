//
//  ProductListViewController.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

import UIKit

final class ProductListViewController: UIViewController {
    private let viewModel: ProductListViewModel
    private let tableView = UITableView()
    private let loader = UIActivityIndicatorView(style: .large)
    private var dataSource: [ProductUIModel] = []
    
    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        Task { await viewModel.loadProducts() }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Catálogo Retail"
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.rowHeight = 84
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        view.addSubview(tableView)
        
        loader.center = view.center
        loader.hidesWhenStopped = true
        view.addSubview(loader)
    }
    
    private func bindViewModel() {
        viewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .idle: self.loader.stopAnimating()
            case .loading: self.loader.startAnimating()
            case .success(let uiModels):
                self.loader.stopAnimating()
                self.dataSource = uiModels
                self.tableView.reloadData()
            case .error: self.loader.stopAnimating()
            }
        }
    }
}

extension ProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.configure(with: dataSource[indexPath.row])
        return cell
    }
}
