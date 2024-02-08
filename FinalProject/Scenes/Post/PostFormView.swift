//
//  PostFormView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 21.01.24.
//

import SwiftUI

struct PostFormView: View, WithRootNavigationController {
    // MARK: - Properties
    @StateObject var postViewModel = PostViewModel()
    @ObservedObject var feedViewModel: FeedViewModel
    @State private var image: Image?
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    @State var isErrorShown: Bool = false
    var existingPost: PostModel? = nil
    var updateCallback: ((PostModel) -> Void)?
    
    // MARK: - Body
    var body: some View {
        ZStack {
            CustomBackgroundLabelForUser()
            
            VStack {
                logo
                
                storyTitleTextField
                
                storyDescriptionTexttField
                
                image?
                    .resizable()
                    .frame(width: 60, height: 60)
                    .scaledToFit()
                    .clipShape(Rectangle())
                    .cornerRadius(6)
                
                // MARK: - Buttons
                Button {
                    showImagePicker = true
                } label: {
                    Image(systemName: "photo.badge.plus.fill")
                        .fontWeight(.bold)
                }
                .primaryButtonStyle
                
                Button {
                    savePost()
                } label: {
                    Text("POST")
                        .fontWeight(.bold)
                }
                .primaryButtonStyle
                .alert(isPresented: $isErrorShown, content: {
                    Alert(title: Text("Missing data"),
                          message: Text("Please upload image or provide desription."),
                          dismissButton: .default(Text("OK"))
                    )
                })
                
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
    
    // MARK: - Computed properties
    var logo: some View {
        Image("mainLogo3")
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 200)
            .offset(y: 50)
    }
    
    var storyTitleTextField: some View {
        TextField("Your story title", text: $postViewModel.title)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(red: 0.95, green: 0.96, blue: 0.97))
            .cornerRadius(30)
    }
    
    var storyDescriptionTexttField: some View {
        TextField("What did you explore?", text: $postViewModel.description, axis: .vertical)
            .lineLimit(6, reservesSpace: true)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(red: 0.95, green: 0.96, blue: 0.97))
            .cornerRadius(30)
            .padding(.vertical, 12)
    }
    
    // MARK: - Methods
    func loadImage() {
        if let inputImage {
            image = Image(uiImage: inputImage)
            postViewModel.imageData = inputImage.jpegData(compressionQuality: 0.1)
        }
    }
    
    func savePost() {
        if postViewModel.description == "" && postViewModel.imageData == nil {
            isErrorShown = true
        } else {
            Task  {
                let (_, _, downloadUrl) = await postViewModel.saveImage() ?? (path: "", name: "", URL(string: ""))
                let savedPost = await postViewModel.savePost(photoUrl: downloadUrl?.absoluteString, postId: existingPost?.id)
                dismiss(animated: true, tab: 0)
                if let savedPost, let updateCallback {
                    updateCallback(savedPost)
                }
            }
        }
        
    }
}

#Preview {
    PostFormView(feedViewModel: FeedViewModel())
}
