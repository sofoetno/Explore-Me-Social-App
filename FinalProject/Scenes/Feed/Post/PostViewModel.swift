//
//  PostViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 21.01.24.
//

import SwiftUI

@MainActor
class PostViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var imageData: Data? = nil
    
    func savePost(photoUrl: String?, postId: String? = nil) async -> PostModel? {
        do {
            return try await PostManager.shared.savePost(
                post: PostModel(title: title, description: description, photoUrl: photoUrl, userId: AuthManager.shared.getAuthenticagedUser()?.uid ?? ""),
                postId: postId
            )
        } catch {
            print(error)
            return nil
        }
    }
    
    func deletePost(postId: String) async {
        try? await PostManager.shared.deletePost(postId: postId)
    }
    
    func saveImage() async -> (path: String, name: String, downloadUrl: URL)? {
        if let imageData {
            do {
                let result = try await ImageManager.shared.saveImage(data: imageData)
                return result
            } catch {
                return nil
            }
        }
        return nil
    }
}

