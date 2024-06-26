//
//  ProfilePageViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 26.01.24.
//

import Foundation

@MainActor
final class ProfilePageViewModel: ObservableObject {
    // MARK: - Properties
    var userId: String = ""
    @Published var imageData: Data? = nil
    @Published var currentProfileImageUrl: String = ""
    @Published var followersCount: Int = 0
    @Published var followingsCount: Int = 0
    @Published var following = false
    @Published var followList: [String] = []
    @Published var fullName: String = ""
    
    // MARK: - Methods
    func changeProfileImage() async -> (path: String, name: String, downloadUrl: URL)? {
        if let imageData {
            do {
                let result = try await ImageManager.shared.saveImage(data: imageData)
                currentProfileImageUrl = result.downloadUrl.absoluteString
                
                if let userId = AuthManager.shared.getAuthenticatedUser()?.uid {
                    try? await UserManager.shared.saveProfileImage(userId: userId, imageUrl: currentProfileImageUrl)
                }
                
                return result
            } catch {
                return nil
            }
        }
        return nil
    }
    
    func getUser() async throws {
        let user = try await UserManager.shared.getUser(by: userId)
        currentProfileImageUrl = user?.imageUrl ?? ""
        fullName = user?.fullName ?? ""
    }
    
    func isMyProfile() -> Bool {
        userId == AuthManager.shared.getAuthenticatedUser()?.uid
    }
    
    func countFollowers() async throws {
        followersCount = try await FollowManager.shared.countFollowers(followingUserId: userId)
    }
    
    func getFollowers() async throws {
        followList = try await FollowManager.shared.getFollows(userId: userId, mode: .followers)
    }
    
    func getFollowings() async throws {
        followList = try await FollowManager.shared.getFollows(userId: userId, mode: .followings)
    }
    
    func follow() async throws {
        try await FollowManager.shared.createFollower(followingId: userId)
        following = true
    }
    
    func unfollow() async throws {
        try await FollowManager.shared.deleteFollower(followingId: userId)
        following = false
    }
    
    func countFollowings() async throws {
        followingsCount = try await FollowManager.shared.countFollowings(followerUserId: userId)
    }
    
    func checkIfFollows() async throws {
        following = try await FollowManager.shared.checkIfFollows(to: userId)
    }
}
