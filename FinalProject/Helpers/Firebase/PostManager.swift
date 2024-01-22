//
//  PostManager.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 21.01.24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class PostManager {
    
    static let shared = PostManager()
    private init() {}
    
    func creatPost(post: PostModel) async throws {
        var postData: [String:Any] = [
            "user_id" : AuthManager.shared.getAuthenticagedUser()?.uid ?? "",
            "title" : post.title,
            "description" : post.description,
            "date_created" : Timestamp(),
        ]
        
        if let photoUrl = post.photoUrl {
            postData["photo_url"] = photoUrl
        }
         
        try await Firestore.firestore().collection("posts").document(post.id).setData(postData, merge: false)
    }
    
    func getPosts() async throws -> [PostModel] {
        let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
        var posts: [PostModel] = []
        snapshot.documents.forEach { document in
            let dictionary = document.data()
            let post = PostModel(
                id: document.documentID,
                title: dictionary["title"] as! String,
                description: dictionary["description"] as! String,
                photoUrl: dictionary["photo_url"] as? String
            )
            posts.append(post)
        }
        return posts
    }
}
