//
//  APIClient.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

import Foundation

enum APIError: Error {
    case badResponse
    case networkError(Error)
}

protocol APIClientProtocol {
    func perform(_ request: URLRequest) async throws -> (Data, HTTPURLResponse)
}

final class APIClient: APIClientProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func perform(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.badResponse
            }
            
            return (data, httpResponse)
        } catch {
            throw APIError.networkError(error)
        }
    }
}
