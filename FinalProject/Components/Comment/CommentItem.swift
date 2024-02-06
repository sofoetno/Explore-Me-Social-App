//
//  CommentItem.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 23.01.24.
//

import SwiftUI

struct CommentItem: View {
    // MARK: - Properties
    let comment: CommentModel
    @StateObject var profileItemViewModel = ProfileItemViewModel()
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            commentUserImage
            
            VStack(alignment: .leading, spacing: 12) {
                commentAuthorName
                
                commentText
                
                commentTime
            }
            .frame(width: 220)
            
        }
        .onAppear() {
            setup()
        }
        .padding()
        .frame(width: 340)
        .background(Color(red: 0.96, green: 0.97, blue: 0.98))
        .cornerRadius(8)
        
    }
    
    // MARK: - Methods
    func setup() {
        profileItemViewModel.userId = comment.userId
        Task {
            try await profileItemViewModel.getUser()
        }
    }
    
    // MARK: - Computed properties
    var commentUserImage: some View {
        CustomAsyncImage(imageUrl: profileItemViewModel.currentProfileImageUrl)
            .clipShape(Circle())
            .frame(width: 44, height: 44)
    }
    
    var commentAuthorName: some View {
        Text(profileItemViewModel.fullName)
            .fontWeight(.bold)
    }
    
    var commentText: some View {
        Text(comment.text)
            .font(.callout)
            .fontWeight(.semibold)
            .multilineTextAlignment(.leading)
    }
    
    var commentTime: some View {
        Text("\(comment.dateCreated.timeAgo()) ago")
            .foregroundStyle(AppColors.darkGray)
            .font(.caption)
    }
}

// MARK: - Preview
#Preview {
    CommentItem(comment: CommentModel(id: "", userId: "QVILtCNWoQOunCgxvcYX6nN8Y9D3", text: "Comment, Comment, Comment, Comment, Comment, Comment", dateCreated: Date(), postId: ""))
}
