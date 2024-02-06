//
//  FeedViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

@MainActor
final class FeedViewModel: ObservableObject {
    // MARK: - Properties
    @Published var posts: [PostModel] = []
    @Published var userId: String? = nil
    
    // MARK: - Inits
    init(userId: String? = nil) {
        self.userId = userId
    }
    
    // MARK: - Methods
    func fetchPosts(searchTerm: String? = nil) async {
        do {
            posts = try await PostManager.shared.getPosts(searchTerm: searchTerm, userId: userId)
        } catch {
            print(error)
        }
    }
}
