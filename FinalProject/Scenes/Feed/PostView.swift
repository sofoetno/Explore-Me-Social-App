//
//  PostView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct PostView: View {
    let post: String
    
    var body: some View {
        Text("Single post \(post)!")
    }
}

#Preview {
    PostView(post: "Test single post")
}
