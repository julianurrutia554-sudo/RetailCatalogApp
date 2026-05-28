//
//  ProductCell.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

import UIKit
import Kingfisher

final class ProductCell: UITableViewCell {
    private let productImageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let badgeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupConstraints() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(badgeLabel)
        
        productImageView.layer.cornerRadius = 8
        productImageView.clipsToBounds = true
        productImageView.contentMode = .scaleAspectFill
        badgeLabel.textColor = .systemRed
        badgeLabel.font = .boldSystemFont(ofSize: 12)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 60),
            productImageView.heightAnchor.constraint(equalToConstant: 60),
            
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            
            badgeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            badgeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with uiModel: ProductUIModel) {
        nameLabel.text = uiModel.title
        priceLabel.text = uiModel.formattedPrice
        badgeLabel.text = uiModel.badgeText
        badgeLabel.isHidden = uiModel.badgeText == nil
        
        guard let url = URL(string: uiModel.imageUrl) else { return }
        productImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
    }
}
