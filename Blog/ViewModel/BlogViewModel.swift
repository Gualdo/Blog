//
//  BlogViewModel.swift
//  Blog
//
//  Created by Eduardo David De La Cruz Marrero on 1/10/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI

class BlogViewModel: ObservableObject {
    
    // Posts...
    @Published var posts: [Post]?
    
    // Errors
    @Published var alertMsg = ""
    @Published var showAlert = false
    
    // New post...
    @Published var createPost = false
    
    func fetchPosts() async {
        do {
            let db = Firestore.firestore().collection("Blog")
            let posts = try await db.getDocuments()
            
            // Converting to our model...
            self.posts = posts.documents.compactMap({ post in
                return try? post.data(as: Post.self)
            })
        } catch {
            alertMsg = error.localizedDescription
            showAlert.toggle()
        }
    }
    
    func deletePost(post: Post) {
        guard let _ = posts else { return }
        
        let index = posts?.firstIndex(where: { currentPost in
            return currentPost.id == post.id
        }) ?? 0
        
        withAnimation { posts?.remove(at: index) }
    }
}
