//
//  CommentItem.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 23.01.24.
//

import SwiftUI

struct CommentItem: View {
    let comment: CommentModel
    @State var isLiked: Bool = false

    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            
            Image("avatar2")
                .resizable()
                .scaledToFit()
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .frame(width: 46, height: 46)

            VStack(alignment: .leading, spacing: 12) {
                Text("author name")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Text(comment.text)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                
                Text("\(comment.dateCreated.timeAgo()) ago")
                    .foregroundStyle(AppColors.darkGray)
                    .font(.caption)
            }
            .frame(width: 220)
            
            HStack {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .foregroundColor(isLiked ? AppColors.customRed : .purple)
                    .font(.title)
            }
            .onTapGesture {
                isLiked.toggle()
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
    CommentItem(comment: CommentModel(id: "", userId: "", text: "Comment, Comment, Comment, Comment, Comment, Comment", dateCreated: Date(), postId: ""))
}
