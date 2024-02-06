//
//  PostView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct PostView: View, WithRootNavigationController {
    // MARK: - Properties
    @State var post: PostModel
    @StateObject var commentViewModel = CommentViewModel()
    @StateObject var postViewModel = PostViewModel()
    @ObservedObject var feedViewModel: FeedViewModel
    @StateObject var likeViewModel = LikeViewModel()
    @StateObject var profileItemViewModel = ProfileItemViewModel()
    
    // MARK: - Body
    var body: some View {
        VStack {
            ScrollView {
                Spacer()
                VStack {
                    HStack {
                        profileImageButton
                        
                        Spacer()
                        
                        PostViewDropDownMenu(feedViewModel: feedViewModel, post: $post)
                    }
                    .padding(.horizontal, 12)
                    
                    CustomAsyncImage(imageUrl: post.photoUrl ?? "")
                        .scaledToFit()
                    
                    HStack {
                        HStack {
                            Like(likeViewModel: likeViewModel)
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "text.bubble")
                                .foregroundColor(.purple)
                            Text("\(commentViewModel.commentsCount)")
                                .foregroundStyle(AppColors.darkGray)
                        }
                    }
                    .padding(.horizontal, 50)
                    .frame(width: 380, height: 50)
                    .background(AppColors.silver)
                    .font(.title)
                    .cornerRadius(10)
                    
                    staticTitleView
                    
                    VStack(alignment: .leading) {
                        
                        Text(post.description)
                            .foregroundColor(AppColors.darkGray)
                        
                    }
                    .padding(.horizontal, 1)
                }
                
                Text("Comments")
                    .padding()
                
                CommentsTable(commentViewModel: commentViewModel)
                    .onAppear() {
                        commentViewModel.postId = post.id
                        Task {
                            await commentViewModel.fetchComments()
                        }
                    }
                    .frame(height: 500)
            }
        }
        .onAppear() {
            setup()
        }
        .safeAreaInset(edge: .bottom) {
            PostCommentTextFieldWithButton(commentViewModel: commentViewModel)
                .padding(.horizontal, 12)
                .frame(height: 78)
                .background(.white)
        }
    }
    
    // MARK: - Methods
    func setup() {
        likeViewModel.postId = post.id
        profileItemViewModel.userId = post.userId
        
        Task {
            try await likeViewModel.checkIfLikes()
            try await commentViewModel.countComments()
            try await profileItemViewModel.getUser()
        }
    }
    
    // MARK: - Buttons
    var profileImageButton: some View {
        Button {
            push(viewController: UIHostingController(rootView: ProfilePageView(userId: post.userId)), animated: true)
        } label: {
            CustomAsyncImage(imageUrl: profileItemViewModel.currentProfileImageUrl)
                .frame(width: 60, height: 60)
                .cornerRadius(6)
                .clipShape(Circle())
            
            Text(profileItemViewModel.fullName)
                .foregroundColor(Color(red: 0.14, green: 0.14, blue: 0.14))
        }
    }
    
    // MARK: - Computed properties
    var staticTitleView: some View {
        VStack {
            Text("Explored Story")
                .font(Font.custom("Circular Std", size: 24))
                .kerning(2)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.65))
                .padding()
        }
    }
}

// MARK: - Preview
#Preview {
    PostView(post: PostModel(title: "Title", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quis risus, neque cursus risus. Eget dictumst vitae enim, felis morbi. Quis risus, neque cursus risus. Eget dictumst vitae enim, felis morbi. Quis risus, neque cursus risus.", photoUrl: "https://firebasestorage.googleapis.com:443/v0/b/finalproject-7d145.appspot.com/o/682D23D8-8713-47A2-A0E1-AF1C8C4DC41B.jpeg?alt=media&token=9654f63f-eaef-4b56-a7c0-543182b74161", userId: "3wAs5TDmywSnXs7KXuQ2i0WXQ2g1"), feedViewModel: FeedViewModel())
}

