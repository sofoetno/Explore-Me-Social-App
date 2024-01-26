//
//  ProfilePageViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 26.01.24.
//

import Foundation

@MainActor
class ProfilePageViewModel: ObservableObject {
    
    @Published var imageData: Data? = nil
    @Published var currentProfileImageUrl: String = ""
    var userId: String = ""
   
        
        func changeProfileImage() async -> (path: String, name: String, downloadUrl: URL)? {
            if let imageData {
                do {
                    let result = try await ImageManager.shared.saveImage(data: imageData)
                    currentProfileImageUrl = result.downloadUrl.absoluteString
                    
                    if let userId = AuthManager.shared.getAuthenticagedUser()?.uid {
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
    }
    
    func isMyProfile() -> Bool {
        userId == AuthManager.shared.getAuthenticagedUser()?.uid
    }
}
