//
//  CustomAsyncImage.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 24.01.24.
//

import SwiftUI

struct CustomAsyncImage: View {
    let imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl )) { phase in
            if let image = phase.image {
                image
                    .resizable()
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

#Preview {
    CustomAsyncImage(imageUrl: "")
}
