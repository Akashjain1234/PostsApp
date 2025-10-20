//
//  PostModel.swift
//  PostsApp
//
//  Created by Akash Jain on 18/10/25.
//

import Foundation

// MARK: - Represents a post fetched from API
struct Post: Identifiable, Codable, Equatable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
