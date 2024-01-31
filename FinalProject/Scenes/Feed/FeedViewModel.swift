//
//  FeedViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

@MainActor
final class FeedViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    @Published var searchTerm: String = ""
    @Published var userId: String? = nil
    
    init(userId: String? = nil) {
        self.userId = userId
    }
    
    
    func fetchPosts() async {
        do {
            posts = try await PostManager.shared.getPosts(searchTerm: searchTerm, userId: userId)
        } catch {
            print(error)
        }
    }
}
