//
//  PostRowView.swift
//  PostsApp
//
//  Created by Akash Jain on 18/10/25.
//

import SwiftUI

/// `PostRowView` displays a single post within the posts list.
/// It shows the post title, user ID, and a heart icon that allows
/// the user to mark or unmark the post as a favorite.
struct PostRowView: View {
    
    // MARK: - Properties
    
    /// The post model containing title, user ID, and other details.
    let post: Post
    
    /// A binding to the favorites storage string shared with the parent view.
    @Binding var favoritesString: String
    
    /// Indicates whether the current post is marked as a favorite.
    private var isFav: Bool {
        FavoritesManager.isFavorite(id: post.id, storageString: favoritesString)
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(post.title)
                    .font(.body)
                    .lineLimit(2)
                
                Text("User ID: \(post.userId)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button {
                favoritesString = FavoritesManager.toggled(id: post.id, storageString: favoritesString)
            } label: {
                Image(systemName: isFav ? IconStringConstants.heartFill : IconStringConstants.heartOutline)
                    .accessibilityLabel(isFav ? "Unmark Favorite" : "Mark Favorite")
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    PostRowView(
        post: Post(userId: 1, id: 1, title: "Sample Post Title", body: "Sample body text."),
        favoritesString: .constant("")
    )
}
