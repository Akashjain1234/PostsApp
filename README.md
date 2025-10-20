# SwiftUI Posts App

A SwiftUI application that fetches posts from an API and provides functionality to view, search, favorite, and inspect post details — built using the **MVVM architecture pattern**.

---

## 🧩 Features

- **View Posts**: Displays all posts fetched from [JSONPlaceholder](https://jsonplaceholder.typicode.com/posts).  
- **Search Posts**: Real-time search by post title using a `TextField`.  
- **Post Details**: Tap on any post to view detailed information (title and body).  
- **Favorites**: Mark/unmark posts as favorites via a heart icon.  
- **Favorites Tab**: A dedicated tab shows all favorited posts.  
- **Optional Enhancements**:
  - Loading indicator while fetching posts  
  - Error handling for failed network requests  
  - Pull-to-refresh support  

---

## 🛠️ Requirements

- **iOS Version:** iOS 17.0 or later  
- **Xcode Version:** Xcode 15 or later  
- **Language:** Swift 5+  
- **Framework:** SwiftUI  

---

## 🧱 Architecture — MVVM

The project follows the **MVVM (Model-View-ViewModel)** design pattern:

- **Model** → Defines the data structure for posts (`Post` model with `userId`, `id`, `title`, and `body`).  
- **ViewModel** → Handles API fetching, search filtering, and favorite state management.  
- **View** → Displays lists, details, and favorites using SwiftUI views.  

All networking logic is isolated from SwiftUI views to maintain a clean separation of concerns.

---

💡 Assumptions & Future Improvements

Currently, favorite status is stored in memory; it can be persisted using UserDefaults or CoreData in future versions.

UI can be enhanced with animations and a custom design system.

Pagination can be added for better performance with large datasets.

Unit tests can be implemented for ViewModel and APIService.
