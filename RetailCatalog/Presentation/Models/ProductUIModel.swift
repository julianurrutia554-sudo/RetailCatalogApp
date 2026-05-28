//
//  ProductUIModel.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

struct ProductUIModel: Identifiable, Equatable {
    let id: String
    let title: String
    let formattedPrice: String
    let badgeText: String?
    let imageUrl: String
}
