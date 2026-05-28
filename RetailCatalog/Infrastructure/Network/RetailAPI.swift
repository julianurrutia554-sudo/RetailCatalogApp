//
//  RetailAPI.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

enum RetailAPI {
    static func getProducts() -> Endpoint {
        return Endpoint(path: "v1/products", method: .get)
    }
}
