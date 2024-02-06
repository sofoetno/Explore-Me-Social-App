//
//  Like.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 27.01.24.
//

import SwiftUI

struct Like: View {
    // MARK: - Properties
    @ObservedObject var likeViewModel: LikeViewModel
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text("\(likeViewModel.likesCount)")
                .foregroundStyle(AppColors.darkGray)
            
            Image(systemName: likeViewModel.isLiked ? "heart.fill" : "heart")
                .foregroundColor(likeViewModel.isLiked ? AppColors.customRed : .purple)
                .font(.title)
        }
        .onAppear() {
            Task {
                try await likeViewModel.countLikes()
            }
        }
        .onTapGesture {
            Task {
                if likeViewModel.isLiked {
                    try await likeViewModel.unlike()
                } else {
                    try await likeViewModel.like()
                }
                try await likeViewModel.countLikes()
            }
            
        }
    }
}

#Preview {
    Like(likeViewModel: LikeViewModel())
}
