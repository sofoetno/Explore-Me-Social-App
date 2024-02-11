//
//  CommentManager.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 22.01.24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class CommentManager {
    
    // MARK: - Static properties
    static let shared = CommentManager()
    
    // MARK: - Inits
    private init() {}
    
    // MARK: - Methods
    func creatComment(text: String, postId: String) async throws {
        let id = UUID().uuidString
        let commentData: [String:Any] = [
            "user_id" : AuthManager.shared.getAuthenticatedUser()?.uid ?? "",
            "text" : text,
            "post_id" : postId,
            "date_created" : Timestamp(),
        ]
        
        try await Firestore.firestore().collection("comments").document(id).setData(commentData, merge: false)
    }
    
    func getComments(by postId: String) async throws -> [CommentModel] {
        let snapshot = try await Firestore.firestore().collection("comments").whereField("post_id", isEqualTo: postId).getDocuments()
        var comments: [CommentModel] = []
        snapshot.documents.forEach { document in
            let dictionary = document.data()
            
            let created = dictionary["date_created"] as! Timestamp
            let dateCreated = created.dateValue()
            
            let comment = CommentModel(
                userId: dictionary["user_id"] as! String,
                text: dictionary["text"] as! String,
                dateCreated: dateCreated,
                postId: dictionary["post_id"] as! String
                
            )
            comments.append(comment)
        }
        return comments
    }
    
    func countComments(by postId: String) async throws -> Int {
        let count = try await Firestore.firestore()
            .collection("comments")
            .whereField("post_id", isEqualTo: postId)
            .count.getAggregation(source: .server).count
        return Int(truncating: count)
    }
}
