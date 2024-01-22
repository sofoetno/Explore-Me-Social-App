//
//  PostViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 21.01.24.
//

import SwiftUI

class PostViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    
    func savePost() async {
        
        try? await PostManager.shared.creatPost(post: PostModel(title: title, description: description))
            
    }
}

