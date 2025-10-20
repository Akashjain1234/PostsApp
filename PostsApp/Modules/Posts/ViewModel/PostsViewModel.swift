//
//  PostsViewModel.swift
//  PostsApp
//
//  Created by Akash Jain on 18/10/25.
//

import Foundation

/// `PostsViewModel` follows the MVVM pattern and serves as the bridge
/// between the `View` layer (SwiftUI screens) and the `Model` layer (`Post`).
/// It handles fetching posts from the network, managing app state,
/// and exposing data to SwiftUI views in a reactive way.
@MainActor
final class PostsViewModel: ObservableObject {

    // MARK: - Published Properties

    /// The list of all posts fetched from the API.
    @Published private(set) var posts: [Post] = []

    /// Text entered in the search field used to filter posts by title.
    @Published var searchText: String = ""

    /// Indicates whether the view model is currently fetching posts.
    @Published var isLoading: Bool = false

    /// Holds an error message (if any) to be displayed in the UI.
    @Published var errorMessage: String? = nil

    // MARK: - Dependencies

    /// Service responsible for making API calls.
    /// Uses dependency injection to allow testing or swapping implementations.
    private let network: NetworkServiceProtocol

    // MARK: - Initialization

    /// Initializes the view model with a network service dependency.
    ///
    /// - Parameter network: An object conforming to `NetworkServiceProtocol`.
    ///   Defaults to `NetworkService()` which uses the live API.
    init(network: NetworkServiceProtocol = NetworkService()) {
        self.network = network
    }

    // MARK: - Computed Properties

    /// Returns the list of posts filtered by the current search text.
    /// - If `searchText` is empty, it returns all posts.
    /// - Filtering is case-insensitive and checks whether the title contains the query.
    var filteredPosts: [Post] {
        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return posts }
        let query = searchText.lowercased()
        return posts.filter { $0.title.lowercased().contains(query) }
    }
}

// MARK: - Network Operations
extension PostsViewModel {

    /// Fetches the list of posts asynchronously from the API.
    ///
    /// This function:
    /// - Ensures only one fetch runs at a time (`isLoading` guard).
    /// - Runs the network call in a background detached task for thread safety.
    /// - Updates published properties (`posts`, `isLoading`, `errorMessage`) on the main actor.
    ///
    /// Works seamlessly with `.task` or `.refreshable` in SwiftUI.
    func fetchPosts() async {
        if isLoading { return }

        isLoading = true
        errorMessage = nil

        do {
            let fetched: [Post] = try await Task.detached(priority: .userInitiated) {
                try await self.network.fetch(StringConstants.postsPath)
            }.value

            await MainActor.run {
                self.posts = fetched
                self.isLoading = false
            }

        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
