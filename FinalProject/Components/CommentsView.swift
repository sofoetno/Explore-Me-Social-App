//
//  CommentView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 22.01.24.
//

import SwiftUI

struct CommentsView: View {
    @ObservedObject var commentViewModel: CommentViewModel
    
    var body: some View {
        Text("Comments")
        
        VStack {
            CommentsTable(commentViewModel: commentViewModel)
        }
        .safeAreaInset(edge: .bottom) {
            VStack {
                
                TextField("Type your comment here...", text: $commentViewModel.text)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .background(Color(red: 0.95, green: 0.96, blue: 0.97))
                    .cornerRadius(30)
                
                
                Button {
                    Task {
                        await commentViewModel.saveComment()
                        await commentViewModel.fetchComments()
                    }
                } label: {
                    Text("Save")
                }
                .primaryButtonStyle
            }
        }
    }
}

#Preview {
    CommentsView(commentViewModel: CommentViewModel())
}
