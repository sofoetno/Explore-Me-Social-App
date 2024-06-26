//
//  PostManager.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 21.01.24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class PostManager {
    
    // MARK: - Static properties
    static let shared = PostManager()
    
    // MARK: - Inits
    private init() {}
    
    // MARK: - Methods
    func savePost(post: PostModel, postId: String? = nil) async throws -> PostModel {
        var postData: [String:Any] = [
            "title" : post.title,
            "description" : post.description
        ]
        
        let userId = AuthManager.shared.getAuthenticatedUser()?.uid ?? ""
        
        if postId == nil {
            postData["user_id"] = userId
            postData["date_created"] = Timestamp()
        }
        
        if let photoUrl = post.photoUrl {
            postData["photo_url"] = photoUrl
        }
        
        let id = postId ?? post.id
        
        try await Firestore.firestore()
            .collection("posts")
            .document(id).setData(postData, merge: postId != nil)
        
        return PostModel(id: id, title: post.title, description: post.description, photoUrl: post.photoUrl, userId: userId)
    }
    
    func deletePost(postId: String) async throws {
        try await Firestore.firestore().collection("posts").document(postId).delete()
    }
    
    func getPosts(searchTerm: String?, userId: String? = nil) async throws -> [PostModel] {
        
        var collection = Firestore.firestore().collection("posts")
            .order(by: "date_created", descending: true)
        if let searchTerm {
            if searchTerm != "" {
                collection = collection
                    .whereField("title", isEqualTo: searchTerm)
            }
        }
        if let userId {
            collection = collection
                .whereField("user_id", isEqualTo: userId)
        }
        
        let snapshot = try await collection.getDocuments()
        
        var posts: [PostModel] = []
        snapshot.documents.forEach { document in
            let dictionary = document.data()
            let post = PostModel(
                id: document.documentID,
                title: dictionary["title"] as! String,
                description: dictionary["description"] as! String,
                photoUrl: dictionary["photo_url"] as? String,
                userId: dictionary["user_id"] as! String
            )
            posts.append(post)
        }
        
        return posts
    }
}
