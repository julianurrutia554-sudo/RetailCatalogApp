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
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(with urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw DataTransferError.badURL
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw DataTransferError.noNetwork
            }
            
            // Validación de códigos de estado HTTP
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
        } catch let error as DataTransferError {
            throw error
        } catch {
            throw DataTransferError.noNetwork
        }
    }
}
