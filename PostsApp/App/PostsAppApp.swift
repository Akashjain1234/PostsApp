//
//  PostsAppApp.swift
//  PostsApp
//
//  Created by Akash Jain on 18/10/25.
//

import SwiftUI

/// The main entry point of the PostsApp.
///
/// Sets up the window and root view, which is a `TabView` containing
/// the Posts list and Favorites list screens.
@main
struct PostsAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            /// Root tab view for navigating between Posts and Favorites
            TabView {
                /// Posts list tab
                PostsListView()
                    .tabItem {
                        Label(StringConstants.postsTitle, systemImage: IconStringConstants.listBullet)
                    }
                
                /// Favorites list tab
                FavoritesListView()
                    .tabItem {
                        Label(StringConstants.favoritesTitle, systemImage: IconStringConstants.heartFill)
                    }
            }
        }
    }
}
