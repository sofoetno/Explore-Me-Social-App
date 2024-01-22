//
//  PostView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct PostView: View {
    let post: PostModel
    @StateObject var commentViewModel = CommentViewModel()
    
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
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "slider.vertical.3")
                                .foregroundColor(Color(red: 0.14, green: 0.14, blue: 0.14))
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .padding(.horizontal, 12)
                        }
                    }
                    .padding(.horizontal, 12)
                    
                    Image("testForPost")
                        .resizable()
                        .scaledToFill()
                    
                    VStack {
                        HStack {
                            Text("The story")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quis risus, neque cursus risus. Eget dictumst vitae enim, felis morbi. Quis risus, neque cursus risus. Eget dictumst vitae enim, felis morbi. Quis risus, neque cursus risus.")
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
}

#Preview {
    PostView(post: PostModel(title: "Title", description: "Desc"))
}

