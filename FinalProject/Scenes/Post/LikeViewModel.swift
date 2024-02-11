//
//  LikeViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 27.01.24.
//

import Foundation

@MainActor
final class LikeViewModel: ObservableObject {
    // MARK: - Properties
    var postId: String = ""
    @Published var isLiked: Bool = false
    @Published var likesCount: Int = 0
    
    // MARK: - Methods
    func checkIfLikes() async throws {
        isLiked = try await LikeManager.shared.checkIfLikes(postId: postId)
    }
    
    func like() async throws {
        try await LikeManager.shared.createLike(postId: postId)
        isLiked = true
    }
    
    func unlike() async throws {
        try await LikeManager.shared.deleteLike(postId: postId)
        isLiked = false
    }
    
    func countLikes() async throws {
        likesCount = try await LikeManager.shared.countLikes(postId: postId)
    }
}
