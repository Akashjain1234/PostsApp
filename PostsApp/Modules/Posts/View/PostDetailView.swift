//
//  PostDetailView.swift
//  PostsApp
//
//  Created by Akash Jain on 18/10/25.
//

import SwiftUI

/// A view that displays the details of a `Post` including its title, body, and favorite status.
///
/// The view allows the user to toggle the favorite state of the post, which is reflected
/// in the provided `favoritesString` binding. The favorite status is managed through
/// `FavoritesManager`.
struct PostDetailView: View {
    /// The post to display.
    let post: Post
    
    /// A binding string that stores the list of favorite post IDs.
    /// Toggling the favorite state updates this string.
    @Binding var favoritesString: String

    /// A computed property to determine whether the current post is marked as favorite.
    private var isFav: Bool {
        FavoritesManager.isFavorite(id: post.id, storageString: favoritesString)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    /// Displays the post title
                    Text(post.title)
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    
                    /// Button to toggle the favorite state of the post
                    Button {
                        favoritesString = FavoritesManager.toggled(id: post.id, storageString: favoritesString)
                    } label: {
                        Image(systemName: isFav ? IconStringConstants.heartFill : IconStringConstants.heartOutline)
                    }
                    .buttonStyle(.plain)
                }
                
                /// Displays the body content of the post
                Text(post.body)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(StringConstants.detailsTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    PostDetailView()
//}
