//
//  PostView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct PostView: View, WithRootNavigationController {
    @State var post: PostModel
    @StateObject var commentViewModel = CommentViewModel()
    @StateObject var postViewModel = PostViewModel()
    @ObservedObject var feedViewModel: FeedViewModel
    @StateObject var likeViewModel = LikeViewModel()
    @StateObject var profileItemViewModel = ProfileItemViewModel()
    
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        
                        Button {
                            push(viewController: UIHostingController(rootView: ProfilePageView(userId: post.userId)), animated: true, tab: 0)
                        } label: {
                            CustomAsyncImage(imageUrl: profileItemViewModel.currentProfileImageUrl)
                                .frame(width: 60, height: 60)
                                .cornerRadius(6)
                                .clipShape(Circle())
                            
                            Text(profileItemViewModel.fullName)
                                .foregroundColor(Color(red: 0.14, green: 0.14, blue: 0.14))
                        }
                        
                       
                        Spacer()
                        
                        PostViewDropDownMenu(feedViewModel: feedViewModel, post: $post)
                    }
                    .padding(.horizontal, 12)
                    
                    CustomAsyncImage(imageUrl: post.photoUrl ?? "")
                        .scaledToFit()
                        .overlay(
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
                                    .background(AppColors.customLightBlue)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(10)

                              
                           .offset(y: 94)
                            )
                    
                    VStack {
                        HStack {
                            Text("The story")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .padding(.vertical, 30)
                        
                        
                        Text(post.description)
                            .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                        
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
            likeViewModel.postId = post.id
            profileItemViewModel.userId = post.userId
            
            Task {
                try await likeViewModel.checkIfLikes()
                try await commentViewModel.countComments()
                try await profileItemViewModel.getUser()
            }
        }
        .safeAreaInset(edge: .bottom) {
            PostCommentTextFieldWithButton(commentViewModel: commentViewModel)
            .padding(.horizontal, 12)
            .frame(height: 78)
            .background(.white)
        }
    }
    
    func goToFeed() {
        self.pop(animated: true, tab: 0)
    }
}

#Preview {
    PostView(post: PostModel(title: "Title", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quis risus, neque cursus risus. Eget dictumst vitae enim, felis morbi. Quis risus, neque cursus risus. Eget dictumst vitae enim, felis morbi. Quis risus, neque cursus risus.", userId: "RskA3hj9VlgFrcAzXNJL9m6rbpZ2"), feedViewModel: FeedViewModel())
}

