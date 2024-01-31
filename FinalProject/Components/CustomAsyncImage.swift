//
//  CustomAsyncImage.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 24.01.24.
//

import SwiftUI

struct ImageCache {
    static var images: [String:Image] = [:]
}

struct CustomAsyncImage: View {
    let imageUrl: String
    
    var body: some View {
        if imageUrl == "" {
            Image("mainLogo")
                .resizable()
                .scaledToFit()
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
                    Image("mainLogo")
                        .resizable()
                        .scaledToFit()
                        .padding(.vertical, 100)
                        .padding(.horizontal, 50)
                }
            }
        }
        
    }
}

#Preview {
    CustomAsyncImage(imageUrl: "")
}
