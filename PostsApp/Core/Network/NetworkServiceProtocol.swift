//
//  NetworkServiceProtocol.swift
//  PostsApp
//
//  Created by Akash Jain on 18/10/25.
//

import Foundation

/// A protocol defining the requirements for a network service that can fetch `Decodable` data.
///
/// Any conforming type must provide a base URL and a generic fetch method that can retrieve
/// and decode data asynchronously from a given API path.
protocol NetworkServiceProtocol {
    
    /// The base URL for all network requests.
    var baseURL: URL { get }
    
    /// Fetches and decodes data from the specified API path.
    ///
    /// - Parameter path: The endpoint path relative to the `baseURL`.
    /// - Returns: A decoded object of type `T` conforming to `Decodable`.
    /// - Throws: An error if the network request fails, the response is invalid,
    ///           or decoding of the response fails.
    func fetch<T: Decodable>(_ path: String) async throws -> T
}
