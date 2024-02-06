//
//  CommentViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 22.01.24.
//

import SwiftUI

@MainActor
final class CommentViewModel: ObservableObject {
    // MARK: - Properties
    @Published var comments: [CommentModel] = []
    @Published var commentsCount: Int = 0
    @Published var text: String = ""
    var postId: String = ""
    
    // MARK: - Methods
    func saveComment() async {
        do {
            try await CommentManager.shared.creatComment(text: text, postId: postId)
        } catch {
            print(error)
        }
    }
    
    func fetchComments() async {
        do {
            comments = try await CommentManager.shared.getComments(by: postId)
        } catch {
            print(error)
        }
    }
    
    func clearForm() {
        text = ""
    }
    
    func countComments() async throws {
        commentsCount = try await CommentManager.shared.countComments(by: postId)
    }
}
