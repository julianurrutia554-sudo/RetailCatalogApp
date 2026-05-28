//
//  ProductMapper.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

final class ProductMapper {
    static func toDomain(dto: ProductDTO) -> Product {
        return Product(
            id: dto.sku_id,
            name: dto.product_title,
            price: dto.sale_price,
            imageUrl: dto.image_url_path
        )
    }
}
