//
//  ProductDTO.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

struct ProductDTO: Decodable {
    let sku_id: String
    let product_title: String
    let sale_price: Double
    let image_url_path: String
}
