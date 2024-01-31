//
//  PostsViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 31.01.24.
//

import Foundation

@MainActor
final class PostsViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    @Published var userId: String? = nil
    
    
    func fetchPosts() async {
        do {
            posts = try await PostManager.shared.getPosts(searchTerm: nil, userId: userId)
        } catch {
            print(error)
        }
    }
}


