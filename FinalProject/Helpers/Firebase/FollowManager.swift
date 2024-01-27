//
//  FollowManager.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 27.01.24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

final class FollowManager {
    static let shared = FollowManager()
    
    private init() {}
    
    func createFollower(followingId: String) async throws {
        let id = UUID().uuidString
        let followerData: [String:Any] = [
            "follower_id" : AuthManager.shared.getAuthenticagedUser()?.uid ?? "",
            "following_id" : followingId
        ]
        
        try await Firestore.firestore().collection("followers").document(id).setData(followerData, merge: false)
    }
    
    func deleteFollower(followingId: String) async throws {

        let snapshot = try await Firestore.firestore().collection("followers")
            .whereField("following_id", isEqualTo: followingId)
            .whereField("follower_id", isEqualTo: AuthManager.shared.getAuthenticagedUser()?.uid ?? "")
            .getDocuments()
        
        var ids: [String] = []
        snapshot.documents.forEach { document in
            ids.append(document.documentID)
        }
        if ids.count > 0 {
            try await Firestore.firestore().collection("followers").document(ids[0]).delete()
        }
    }
    
    func countFollowers(followingUserId: String) async throws -> Int {
        let count = try await Firestore.firestore()
            .collection("followers")
            .whereField("following_id", isEqualTo: followingUserId)
            .count.getAggregation(source: .server).count
        return Int(truncating: count)
    }
    
    func countFollowings(followerUserId: String) async throws -> Int {
        let count = try await Firestore.firestore()
            .collection("followers")
            .whereField("follower_id", isEqualTo: followerUserId)
            .count.getAggregation(source: .server).count
        return Int(truncating: count)
    }
    
    func checkIfFollows(to followingUserId: String) async throws -> Bool {
        let count = try await Firestore.firestore().collection("followers")
            .whereField("following_id", isEqualTo: followingUserId)
            .whereField("follower_id", isEqualTo: AuthManager.shared.getAuthenticagedUser()?.uid ?? "")
            .count.getAggregation(source: .server).count
        
        return Int(truncating: count) > 0
    }
}
