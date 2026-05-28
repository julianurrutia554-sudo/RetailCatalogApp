//
//  Product.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

struct Product: Identifiable, Equatable {
    let id: String
    let name: String
    let price: Double
    let imageUrl: String
}
