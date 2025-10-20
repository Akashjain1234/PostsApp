//
//  FavoritesManager.swift
//  PostsApp
//
//  Created by Akash Jain on 18/10/25.
//

import Foundation
import SwiftUI

/// A helper struct to manage favorite post IDs stored as a comma-separated string in `AppStorage`.
///
/// `FavoritesManager` is **not** an `ObservableObject`. Views should use `@AppStorage` directly
/// for automatic updates when the stored string changes. This manager provides utility functions
/// to convert between the string representation and a `Set<Int>` of post IDs, as well as checking
/// and toggling favorite status.
struct FavoritesManager {
    /// The key used in `AppStorage` to store the user's favorite post IDs.
    static let key = StringConstants.favoritesKey

    /// Converts a comma-separated string of IDs into a `Set<Int>`.
    ///
    /// - Parameter string: The stored string of IDs, e.g., "1,2,5".
    /// - Returns: A set of integers representing favorite post IDs. Returns an empty set if the string is empty or invalid.
    static func getSet(from string: String) -> Set<Int> {
        guard !string.isEmpty else { return [] }
        return Set(string.split(separator: ",").compactMap { Int($0) })
    }

    /// Converts a `Set<Int>` of IDs into a comma-separated string for storage.
    ///
    /// - Parameter set: A set of integers representing favorite post IDs.
    /// - Returns: A string representation suitable for `AppStorage`.
    static func string(from set: Set<Int>) -> String {
        set.map(String.init).joined(separator: ",")
    }

    /// Checks if a given post ID is marked as favorite.
    ///
    /// - Parameters:
    ///   - id: The post ID to check.
    ///   - storageString: The string from `AppStorage` containing favorite IDs.
    /// - Returns: `true` if the ID is in the favorites set, `false` otherwise.
    static func isFavorite(id: Int, storageString: String) -> Bool {
        getSet(from: storageString).contains(id)
    }

    /// Toggles the favorite state of a given post ID.
    ///
    /// If the ID exists in the favorites set, it is removed; otherwise, it is added.
    ///
    /// - Parameters:
    ///   - id: The post ID to toggle.
    ///   - storageString: The string from `AppStorage` containing favorite IDs.
    /// - Returns: An updated string suitable for storing back into `AppStorage`.
    static func toggled(id: Int, storageString: String) -> String {
        var set = getSet(from: storageString)
        if set.contains(id) { set.remove(id) } else { set.insert(id) }
        return string(from: set)
    }
}
