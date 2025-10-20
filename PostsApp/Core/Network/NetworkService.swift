//
//  NetworkService.swift
//  PostsApp
//
//  Created by Akash Jain on 18/10/25.
//

import Foundation

// MARK: - Network Service

/// A concrete implementation of `NetworkServiceProtocol` for fetching data from a REST API.
///
/// `NetworkService` supports dynamic base URLs, making it testable and reusable. It provides
/// async fetching with automatic decoding of JSON responses into `Decodable` types.
final class NetworkService: NetworkServiceProtocol {
    
    /// The base URL for all network requests.
    let baseURL: URL
    
    /// Initializes the service with a base URL.
    ///
    /// - Parameter baseURL: The root URL of the API. Defaults to `https://jsonplaceholder.typicode.com`.
    init(baseURL: URL = URL(string: StringConstants.baseURL)!) {
        self.baseURL = baseURL
    }
    
    /// Represents errors that can occur during network operations.
    enum NetworkError: Error, LocalizedError {
        /// The server returned an invalid or unexpected response.
        case invalidResponse
        
        /// JSON decoding failed with the underlying error.
        case decodingFailed(Error)
        
        /// A user-readable description of the error.
        var errorDescription: String? {
            switch self {
            case .invalidResponse: return "Invalid response from server."
            case .decodingFailed(let err): return "Decoding failed: \(err.localizedDescription)"
            }
        }
    }
}

// MARK: - Fetch

extension NetworkService {
    
    /// Fetches and decodes data from the given API path.
    ///
    /// - Parameter path: The endpoint path relative to the `baseURL`.
    /// - Returns: A decoded object of type `T` conforming to `Decodable`.
    /// - Throws: `NetworkError.invalidResponse` if the HTTP response is not 2xx.
    ///           `NetworkError.decodingFailed` if JSON decoding fails.
    func fetch<T: Decodable>(_ path: String) async throws -> T {
        
        let url = baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
