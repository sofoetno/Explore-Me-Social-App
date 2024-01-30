//
//  PostCommentTextFieldWithButton.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 30.01.24.
//

import SwiftUI

struct PostCommentTextFieldWithButton: View {
    @ObservedObject var commentViewModel: CommentViewModel
    
    var body: some View {
        ZStack {
            TextField("Type your comment here...", text: $commentViewModel.text)
                .padding(.horizontal, 10)
                .padding(.vertical, 16)
                .background(Color(red: 0.95, green: 0.96, blue: 0.97))
                .cornerRadius(10)
            
            
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
            .offset(x: 140)
            
        }
    }
}

#Preview {
    PostCommentTextFieldWithButton(commentViewModel: CommentViewModel())
}
