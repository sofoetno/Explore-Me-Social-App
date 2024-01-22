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
    
    func savePost(photoUrl: String?) async {
        try? await PostManager.shared.creatPost(post: PostModel(title: title, description: description, photoUrl: photoUrl))
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

