//
//  PostItem.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct PostItem: View, WithRootNavigationController {
    let post: PostModel
    @StateObject var likeViewModel = LikeViewModel()
    @StateObject var postItemViewModel = ProfileItemViewModel()
    
    var body: some View {
    
        ZStack {
            ZStack {
                CustomAsyncImage(imageUrl: post.photoUrl ?? "")
                    .scaledToFit()
                    .cornerRadius(10)
                
               
                
                Like(likeViewModel: likeViewModel)
                    .offset(x: 120, y: -90)
            }
            
            ZStack {
                CustomRectangleForCell()
                    .overlay {
                        
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 74, height: 74)
                            
                            
                            CustomAsyncImage(imageUrl: postItemViewModel.currentProfileImageUrl)
                                .frame(width: 70, height: 70)
                                .cornerRadius(6)
                                .clipShape(Circle())
                                .shadow(color: .white, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                .onTapGesture {
                                    push(viewController: UIHostingController(rootView: ProfilePageView(userId: post.userId)), animated: true)
                                }
                        }
                        .offset(y: -94)
                    
                    }
                   
                
                VStack(spacing: 8) {
                    Text("Explore the story: \(post.title)")
                        .foregroundStyle(.white)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .frame(width: 280, alignment: .topLeading)
                    
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 300, height: 1)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.98, green: 0.97, blue: 0.97).opacity(0), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.98, green: 0.98, blue: 0.98), location: 0.09),
                                    Gradient.Stop(color: Color(red: 0.98, green: 0.97, blue: 0.97).opacity(0), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0, y: 1),
                                endPoint: UnitPoint(x: 1, y: 1)
                            )
                        )
                    
                    Text(post.description)
                        .font(Font.custom("Inter", size: 15))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(width: 280, height: 64, alignment: .topLeading)
                }
            }
            .offset(y: 90)
        }
        .frame(height: 324)
        .shadow(color: Color(red: 0.2, green: 0.33, blue: 0.55).opacity(0.3), radius: 22, x: 0, y: 14)
        .onAppear() {
            likeViewModel.postId = post.id
            postItemViewModel.userId = post.userId
            
            Task {
                try await postItemViewModel.getUser()
                try await likeViewModel.checkIfLikes()
            }
        }
    }
}

#Preview {
    PostItem(post: PostModel(title: "Story name", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quis risus, neque cursus risus. Eget dictumst vitae enim, felis morbi. Quis risus, neque cursus risus. Eget dictumst vitae enim, felis morbi. Quis risus, neque cursus risus.", photoUrl: "https://firebasestorage.googleapis.com:443/v0/b/finalproject-7d145.appspot.com/o/2EC57CE8-CA9E-4428-8117-8F0679E03C18.jpeg?alt=media&token=44d7fda9-e87b-4004-b5ea-719c5d266431", userId: "Eu507agEdHMVyFOV2ldbggmq9xw1"))
}
