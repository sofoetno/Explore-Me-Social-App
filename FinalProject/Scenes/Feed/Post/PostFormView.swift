//
//  PostFormView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 21.01.24.
//

import SwiftUI

struct PostFormView: View, WithRootNavigationController {
    
    @StateObject var postViewModel = PostViewModel()
    @ObservedObject var feedViewModel: FeedViewModel
    @State private var image: Image?
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    var existingPost: PostModel? = nil
    var updateCallback: ((PostModel) -> Void)?
    
    var body: some View {
        ZStack {
            CustomBackgroundLabelForUser()
            
            VStack {
                Image("mainLogo3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
                    .offset(y: 50)
                
                TextField("Your story title", text: $postViewModel.title)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .background(Color(red: 0.95, green: 0.96, blue: 0.97))
                    .cornerRadius(30)
                
                TextField("What did you explore?", text: $postViewModel.description, axis: .vertical)
                    .lineLimit(6, reservesSpace: true)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .background(Color(red: 0.95, green: 0.96, blue: 0.97))
                    .cornerRadius(30)
                    .padding(.vertical, 12)
                
                image?
                    .resizable()
                    .frame(width: 60, height: 60)
                    .scaledToFit()
                    .clipShape(Rectangle())
                    .cornerRadius(6)
                
                
                Button {
                    showImagePicker = true
                } label: {
                    Text("add image")
                }
                .primaryButtonStyle
                
                Button {
                    Task  {
                        let (_, _, downloadUrl) = await postViewModel.saveImage() ?? (path: "", name: "", URL(string: ""))
                        let savedPost = await postViewModel.savePost(photoUrl: downloadUrl?.absoluteString, postId: existingPost?.id)
                        dismiss(animated: true, tab: 1)
                        await feedViewModel.fetchPosts()
                        if let savedPost, let updateCallback {
                            updateCallback(savedPost)
                        }
                    }
                } label: {
                    Text("POST")
                        .fontWeight(.bold)
                }
                .primaryButtonStyle
            }
            .padding()
            .onChange(of: inputImage) { _, _ in loadImage() }
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(image: $inputImage)
            })
            .onAppear() {
                if let existingPost {
                    postViewModel.title = existingPost.title
                    postViewModel.description = existingPost.description
                }
            }
        }
    }
    
    func loadImage() {
        if let inputImage {
            image = Image(uiImage: inputImage)
            postViewModel.imageData = inputImage.jpegData(compressionQuality: 0.1)
        }
    }
}

#Preview {
    PostFormView(feedViewModel: FeedViewModel())
}
