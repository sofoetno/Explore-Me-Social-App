//
//  ProfilePageView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 19.01.24.
//

import SwiftUI

struct ProfilePageView: View, WithRootNavigationController {
    // MARK: - Properties
    let userId: String
    @State var showImagePicker = false
    @State var inputImage: UIImage?
    @StateObject var profilePageViewModel = ProfilePageViewModel()
    @StateObject var feedViewModel = FeedViewModel()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            CustomBackgroundLabelForUser()
                .offset(y: 40)
            
            HStack {
                if profilePageViewModel.isMyProfile() {
                    LogoutButton()
                }
                
                if !profilePageViewModel.isMyProfile() {
                    messageButton
                }
                
                Spacer()
                
                if !profilePageViewModel.isMyProfile() {
                    followButton
                }
            }
            .padding(.horizontal, 20)
            .offset(y: -320)
            
            VStack {
                profilePhotoBackgroundCircle
                    .overlay(
                        profileAsyncImage
                    )
                    .overlay {
                        if profilePageViewModel.isMyProfile() {
                            addImageButton
                                .sheet(isPresented: $showImagePicker, content: {
                                    ImagePicker(image: $inputImage)
                                })
                                .offset(x: 34, y: 38)
                            
                        } else {
                            EmptyView()
                        }
                        
                    }
            }
            .onChange(of: inputImage, { _, _ in
                profilePageViewModel.imageData = inputImage?.jpegData(compressionQuality: 0.1)
                Task {
                    await profilePageViewModel.changeProfileImage()
                }
            })
            .offset(y: -230)
            
            VStack() {
                Text(profilePageViewModel.fullName)
                    .font(.title)
                
                HStack(alignment: .center, spacing: 48) {
                    followersCountButton
                    
                    followingCountButton
                }
                .padding(.vertical, 20)
                .frame(width: 347, alignment: .center)
                .background(Color(red: 0.96, green: 0.97, blue: 0.98))
                .cornerRadius(6)
            }
            .offset(y: -110)
            
            PostsCollection(feedViewModel: feedViewModel)
                .offset(y: 350)
                .onAppear() {
                    feedViewModel.userId = userId
                    Task {
                        await feedViewModel.fetchPosts()
                    }
                }
                .zIndex(-1)
        }
        .onAppear() {
            setup()
        }
    }
    
    // MARK: - Buttons
    var messageButton: some View {
        Button {
            let viewController =  UIHostingController(rootView: ChatView(chatId: nil, participantId: userId))
            viewController.hidesBottomBarWhenPushed = true
            push(viewController: viewController, animated: true)
           
        } label: {
            Image(systemName: "ellipsis.message")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }
    
    var followButton: some View {
        Button {
            Task {
                if profilePageViewModel.following {
                    try await profilePageViewModel.unfollow()
                } else {
                    try await profilePageViewModel.follow()
                }
                try await profilePageViewModel.countFollowers()
            }
            
        } label: {
            Capsule()
                .frame(width: 100, height: 40)
                .foregroundColor(.white)
                .overlay {
                    if profilePageViewModel.following {
                        Text("Following")
                            .foregroundColor(Color(red: 0.53, green: 0.55, blue: 0.96))
                    } else {
                        Text("Follow")
                            .foregroundColor(Color(red: 0.53, green: 0.55, blue: 0.96))
                    }
                    
                }
        }
    }
    
    var addImageButton: some View {
        Button {
            showImagePicker = true
        } label: {
            Image(systemName: "square.and.pencil.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.purple)
        }
    }
    
    var followersCountButton: some View {
        Button {
            present(viewController: UIHostingController(rootView: FollowView(userId: userId)), animated: true)
        } label: {
            Text("\(profilePageViewModel.followersCount) Followers")
                .kerning(0.6)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.14, green: 0.14, blue: 0.14))
        }
    }
    
    var followingCountButton: some View {
        Button {
            present(viewController: UIHostingController(rootView: FollowView(userId: userId, isFollowing: true)), animated: true)
        } label: {
            Text("\(profilePageViewModel.followingsCount) Following")
                .kerning(0.6)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.14, green: 0.14, blue: 0.14))
        }
    }
    
    // MARK: - Methods
    func setup() {
        profilePageViewModel.userId = userId
        Task {
            do {
                try await profilePageViewModel.getUser()
                try await profilePageViewModel.countFollowers()
                try await profilePageViewModel.countFollowings()
                try await profilePageViewModel.checkIfFollows()
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - Computed properties
    var profilePhotoBackgroundCircle: some View {
        Circle()
            .foregroundColor(.white)
            .frame(width: 100, height: 100)
    }
    
    var profileAsyncImage: some View {
        CustomAsyncImage(imageUrl: profilePageViewModel.currentProfileImageUrl)
            .frame(width: 90, height: 90)
            .scaledToFit()
            .cornerRadius(6)
            .clipShape(Circle())
    }
    
}

// MARK: - Preview
#Preview {
    ProfilePageView(userId: "Eu507agEdHMVyFOV2ldbggmq9xw1")
}
