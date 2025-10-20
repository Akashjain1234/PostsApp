//
//  PostsListView.swift
//  PostsApp
//
//  Created by Akash Jain on 18/10/25.
//

import SwiftUI


/// `PostsListView` is the main screen displaying all posts fetched from the API.
/// It allows users to:
/// - View posts in a list
/// - Search posts by title
/// - Navigate to detailed post view
/// - Mark or unmark posts as favorites
/// - Pull down to refresh the list
struct PostsListView: View {
    
    // MARK: - Properties
    
    /// View model responsible for managing the posts data and search functionality.
    @StateObject private var viewModel = PostsViewModel()
    
    /// Stores a comma-separated list of favorite post IDs in app storage.
    @AppStorage(FavoritesManager.key) private var favoritesString: String = ""
    
    // MARK: - Body

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    VStack {
                        ProgressView()
                        Text(StringConstants.loadingMessage)
                            .padding(.top, 6)
                    }
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text(StringConstants.errorMessage)
                            .font(.title2)
                        Text(error)
                            .multilineTextAlignment(.center)
                        Button(StringConstants.retryButton) {
                            Task { await viewModel.fetchPosts() }
                        }
                    }
                    .padding()
                } else {
                    List(viewModel.filteredPosts) { post in
                        NavigationLink(
                            destination: PostDetailView(
                                post: post,
                                favoritesString: $favoritesString
                            )
                        ) {
                            PostRowView(
                                post: post,
                                favoritesString: $favoritesString
                            )
                        }
                    }
                    .listStyle(.plain)
                    .searchable(text: $viewModel.searchText, prompt: StringConstants.searchPlaceholder)
                    .refreshable {
                        await viewModel.fetchPosts()
                    }
                }
            }
            .navigationTitle(StringConstants.postsTitle)
        }
        .task {
            if viewModel.posts.isEmpty {
                await viewModel.fetchPosts()
            }
        }
    }
}

#Preview {
    PostsListView()
}
