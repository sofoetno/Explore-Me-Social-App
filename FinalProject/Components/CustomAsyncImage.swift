//
//  CustomAsyncImage.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 24.01.24.
//

import SwiftUI

struct ImageCache {
    // MARK: - Static properties
    static var images: [String:Image] = [:]
}

struct CustomAsyncImage: View {
    // MARK: - Properties
    let imageUrl: String
    
    // MARK: - Body
    var body: some View {
        if imageUrl == "" {
            Image(systemName: "photo.artframe.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(AppColors.lightGray)
        }
        else if ImageCache.images[imageUrl] != nil {
            ImageCache.images[imageUrl]?
                .resizable()
        } else {
            AsyncImage(url: URL(string: imageUrl)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .onAppear() {
                            ImageCache.images[imageUrl] = image
                        }
                } else {
                    ProgressView()
                }
            }
        }
        
    }
}

// MARK: - Preview
#Preview {
    CustomAsyncImage(imageUrl: "photo.artframe.circle")
}
