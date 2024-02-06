//
//  PostCommentTextFieldWithButton.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 30.01.24.
//

import SwiftUI

struct PostCommentTextFieldWithButton: View {
    // MARK: - Methods
    @ObservedObject var commentViewModel: CommentViewModel
    
    // MARK: - Body
    var body: some View {
        ZStack {
            texttFieldForComment

            sendCommentButton
            .offset(x: 140)
        }
    }
    
    // MARK: - Computed properties
    var texttFieldForComment: some View {
        TextField("Type your comment here...", text: $commentViewModel.text)
            .padding(.horizontal, 10)
            .padding(.vertical, 16)
            .background(Color(red: 0.95, green: 0.96, blue: 0.97))
            .cornerRadius(10)
    }
    
    // MARK: - Buttons
    var sendCommentButton: some View {
        Button {
            Task {
                await commentViewModel.saveComment()
                commentViewModel.clearForm()
                await commentViewModel.fetchComments()
                try await commentViewModel.countComments()
            }
        } label: {
            Image(systemName: "arrow.right.circle")
                .font(.largeTitle)
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Preview
#Preview {
    PostCommentTextFieldWithButton(commentViewModel: CommentViewModel())
}
