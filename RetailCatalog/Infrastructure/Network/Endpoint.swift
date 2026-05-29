//
//  Endpoint.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let queryParameters: [String: String]?
    
    init(path: String, method: HTTPMethod = .get, queryParameters: [String: String]? = nil) {
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
    }
    
    func urlRequest(with baseUrl: String) -> URLRequest? {
        guard let urlBase = URL(string: baseUrl) else { return nil }
        let urlFull = urlBase.appendingPathComponent(path)
        
        guard var components = URLComponents(url: urlFull, resolvingAgainstBaseURL: false) else { return nil }
        
        if let queryParameters = queryParameters {
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
