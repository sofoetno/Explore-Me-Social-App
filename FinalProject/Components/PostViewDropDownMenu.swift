//
//  PostViewDropDownMenu.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 24.01.24.
//

import SwiftUI

struct PostViewDropDownMenu: View, WithRootNavigationController {
    
    @StateObject var postViewModel = PostViewModel()
    @ObservedObject var feedViewModel: FeedViewModel
    @Binding var post: PostModel
    
    var body: some View {
        Menu {
            Button("Edit") {
                openPostForm()
            }
            
            Button("Delete", role: .destructive) {
                Task {
                    await postViewModel.deletePost(postId: post.id)
                    pop(animated: true, tab: 0)
                }
            }
        } label: {
            Label("Menu", systemImage: "slider.vertical.3")
                .foregroundColor(Color(red: 0.14, green: 0.14, blue: 0.14))
                .font(.title2)
                .padding(.horizontal, 12)
            
        }
    }
    
    func openPostForm() {
        present(
            viewController: UIHostingController(
                rootView: PostFormView(
                    feedViewModel: feedViewModel,
                    existingPost: post,
                    updateCallback: { post in self.post = post }
                )
            ),
            animated: true,
            tab: 1
        )
    }
}

#Preview {
    PostViewDropDownMenu(feedViewModel: FeedViewModel(), post: .constant(PostModel(id: "", title: "", description: "", photoUrl: "")))
}
