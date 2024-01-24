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
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        
                        Image("testForPost2")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(6)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                        
                        Text("José Saramago")
                            .foregroundColor(Color(red: 0.14, green: 0.14, blue: 0.14))
                        Spacer()
                        
                        PostViewDropDownMenu(feedViewModel: feedViewModel, post: $post)
                    }
                    .padding(.horizontal, 12)
                    
                    CustomAsyncImage(imageUrl: post.photoUrl ?? "")
                    
                    VStack {
                        HStack {
                            Text("The story")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        
                        
                        Text(post.description)
                            .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                        
                    }
                    .padding()
                }
                
                Text("Comments")
                
                CommentsTable(commentViewModel: commentViewModel)
                    .onAppear() {
                        commentViewModel.postId = post.id
                        Task {
                            await commentViewModel.fetchComments()
                        }
                    }
                    .frame(height: 1000)
            }
        }
        .safeAreaInset(edge: .bottom) {
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
                    }
                } label: {
                    Image(systemName: "arrow.right.circle")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                .offset(x: 140)
                
            }
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
    PostView(post: PostModel(title: "Title", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quis risus, neque cursus risus. Eget dictumst vitae enim, felis morbi. Quis risus, neque cursus risus. Eget dictumst vitae enim, felis morbi. Quis risus, neque cursus risus."), feedViewModel: FeedViewModel())
}

