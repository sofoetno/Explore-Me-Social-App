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
    
    var body: some View {
        TextField("Title", text: $postViewModel.title)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .frame(width: .infinity, alignment: .leading)
            .background(Color(red: 0.95, green: 0.96, blue: 0.97))
            .cornerRadius(30)
        
        TextField("description", text: $postViewModel.description, axis: .vertical)
            .lineLimit(4, reservesSpace: true)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .frame(width: .infinity, alignment: .leading)
            .background(Color(red: 0.95, green: 0.96, blue: 0.97))
            .cornerRadius(30)
        
        Button {
            Task  {
                await postViewModel.savePost()
                await feedViewModel.fetchPosts()
                dismiss(animated: true, tab: 1)
            }

        } label: {
            Text("Save")
        }
        .primaryButtonStyle

    }
}
//
//#Preview {
//    PostFormView()
//}
