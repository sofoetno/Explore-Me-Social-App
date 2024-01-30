//
//  CommentItem.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 23.01.24.
//

import SwiftUI

struct CommentItem: View {
    let comment: CommentModel
    @StateObject var profileItemViewModel = ProfileItemViewModel()
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            
            CustomAsyncImage(imageUrl: profileItemViewModel.currentProfileImageUrl)
                .clipShape(Circle())
                .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: 12) {
                Text("author name")
                    .fontWeight(.bold)
                
                Text(comment.text)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                
                Text("\(comment.dateCreated.timeAgo()) ago")
                    .foregroundStyle(AppColors.darkGray)
                    .font(.caption)
            }
            .frame(width: 220)
            
            
            }
        .onAppear() {
            profileItemViewModel.userId = comment.userId
            Task {
               try await profileItemViewModel.getUser()
            }
        }
        .padding()
        .frame(width: 340)
        .background(Color(red: 0.96, green: 0.97, blue: 0.98))
        .cornerRadius(8)
            
        }
}

extension Date {
    func timeAgo() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        return String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current)
    }
}

#Preview {
    CommentItem(comment: CommentModel(id: "", userId: "QVILtCNWoQOunCgxvcYX6nN8Y9D3", text: "Comment, Comment, Comment, Comment, Comment, Comment", dateCreated: Date(), postId: ""))
}
