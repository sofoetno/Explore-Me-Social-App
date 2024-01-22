//
//  PostView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct PostView: View {
    let post: PostModel
    
    var body: some View {
        Text("Single post \(post.title)!")
    }
}

#Preview {
    PostView(post: PostModel(title: "Title", description: "Desc"))
}
