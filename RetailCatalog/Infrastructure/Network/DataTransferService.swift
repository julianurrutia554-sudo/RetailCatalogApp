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
    func request<T: Decodable>(with urlString: String) async throws -> T
}

final class DataTransferService: DataTransferServiceProtocol {

    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func request<T: Decodable>(with urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else { throw DataTransferError.badURL }
        
        let request = URLRequest(url: url)
        
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
