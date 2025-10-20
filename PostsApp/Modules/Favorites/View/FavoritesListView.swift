//
//  FavoritesListView.swift
//  PostsApp
//
//  Created by Akash Jain on 18/10/25.
//

import SwiftUI

/// A view that displays a list of the user's favorite posts.
///
/// This view fetches all posts using `PostsViewModel` and filters them
/// based on the user's favorite post IDs stored in `AppStorage`.
/// Users can navigate to `PostDetailView` to see details and toggle favorites.
struct FavoritesListView: View {
    /// The view model responsible for fetching and storing all posts.
    @StateObject private var viewModel = PostsViewModel()
    
    /// A string stored in `AppStorage` representing the user's favorite post IDs.
    /// Updated automatically when a post is favorited or unfavorited.
    @AppStorage(FavoritesManager.key) private var favoritesString: String = ""

    var body: some View {
        NavigationView {
            Group {
                /// Show a loading indicator while posts are being fetched
                if viewModel.isLoading {
                    VStack {
                        ProgressView()
                        Text(StringConstants.loadingMessage).padding(.top, 6)
                    }
                }
                /// Show an error message and retry button if fetching fails
                else if let error = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text(StringConstants.errorMessage).font(.title2)
                        Text(error).multilineTextAlignment(.center)
                        Button(StringConstants.retryButton) { Task { await viewModel.fetchPosts() } }
                    }
                    .padding()
                }
                /// Display favorite posts if available
                else {
                    let favIDs = FavoritesManager.getSet(from: favoritesString)
                    let favPosts = viewModel.posts.filter { favIDs.contains($0.id) }
                    
                    /// Show placeholder if no favorite posts exist
                    if favPosts.isEmpty {
                        VStack {
                            Text(StringConstants.noFavoritesMessage)
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                    }
                    /// List all favorite posts with navigation to details
                    else {
                        List(favPosts) { post in
                            NavigationLink(destination: PostDetailView(post: post, favoritesString: $favoritesString)) {
                                PostRowView(post: post, favoritesString: $favoritesString)
                            }
                        }
                        .listStyle(.plain)
                        .refreshable { await viewModel.fetchPosts() }
                    }
                }
            }
            .navigationTitle(StringConstants.favoritesTitle)
        }
        /// Fetch posts when the view appears if none are loaded yet
        .task {
            if viewModel.posts.isEmpty { await viewModel.fetchPosts() }
        }
    }
}

#Preview {
    FavoritesListView()
}
