//
//  StringConstants.swift
//  PostsApp
//
//  Created by Akash Jain on 18/10/25.
//

import Foundation

/// A centralized collection of string constants used throughout the app.
///
/// This includes API endpoints, storage keys, UI titles, placeholders, and user-facing messages.
enum StringConstants {
    
    // MARK: - API
    
    /// Base URL for network requests.
    static let baseURL = "https://jsonplaceholder.typicode.com"
    
    /// Path for fetching posts.
    static let postsPath = "/posts"
    
    
    // MARK: - Storage Keys
    
    /// Key used in `AppStorage` for storing favorite post IDs.
    static let favoritesKey = "favorite_post_ids"
    
    
    // MARK: - UI Titles
    
    /// Title for the posts list screen.
    static let postsTitle = "Posts"
    
    /// Title for the favorites list screen.
    static let favoritesTitle = "Favorites"
    
    /// Title for the post details screen.
    static let detailsTitle = "Details"
    
    /// Placeholder text for the search bar in posts list.
    static let searchPlaceholder = "Search posts by title"
    
    
    // MARK: - Messages
    
    /// Message displayed while loading content.
    static let loadingMessage = "Loading..."
    
    /// Message displayed when there are no favorite posts.
    static let noFavoritesMessage = "No favorite posts yet."
    
    /// Title for the retry button shown on error screens.
    static let retryButton = "Retry"
    
    /// Message displayed when there is error.
    static let errorMessage = "Error"
}

enum IconStringConstants {
    
    static let heartFill = "heart.fill"
    
    static let heartOutline = "heart"
    
    static let listBullet = "list.bullet"
}
