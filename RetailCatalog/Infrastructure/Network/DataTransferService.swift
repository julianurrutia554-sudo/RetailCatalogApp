//
//  DataTransferService.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

import Foundation

enum DataTransferError: Error {
    case noNetwork
    case parsingFailed
    case networkFailure(statusCode: Int)
    case badURL
}

protocol DataTransferServiceProtocol {
    func request<T: Decodable>(with endpoint: Endpoint) async throws -> T
}

final class DataTransferService: DataTransferServiceProtocol {
    private let apiClient: APIClientProtocol
    private let baseUrl: String
    
    // Inyectamos la URL base de manera centralizada (ideal para leerla de un archivo .xcconfig o Info.plist)
    init(apiClient: APIClientProtocol, baseUrl: String = "https://api.myretail.com/") {
        self.apiClient = apiClient
        self.baseUrl = baseUrl
    }
    
    func request<T: Decodable>(with endpoint: Endpoint) async throws -> T {
        // Construimos el URLRequest delegando la responsabilidad al objeto Endpoint
        guard let request = endpoint.urlRequest(with: baseUrl) else {
            throw DataTransferError.badURL
        }
        
        do {
            let (data, httpResponse) = try await apiClient.perform(request)
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw DataTransferError.parsingFailed
                }
            default:
                throw DataTransferError.networkFailure(statusCode: httpResponse.statusCode)
            }
        } catch {
            throw DataTransferError.noNetwork
        }
    }
}
