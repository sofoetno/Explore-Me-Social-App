//
//  FeedView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct FeedView: View {
    // MARK: - Properties
    @StateObject var feedViewModel = FeedViewModel()
    
    // MARK: - Body
    var body: some View {
        Spacer()
        
        VStack(alignment: .trailing, spacing: 12) {
            Spacer()
            VStack(alignment: .trailing, spacing: 10) {
                Image("mainLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170)
                FeedBar(feedViewModel: feedViewModel)
            }
            .padding(.horizontal, 16)
            
            PostsTable(feedViewModel: feedViewModel)
        }
        .onAppear() {
            Task {
                await feedViewModel.fetchPosts()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    FeedView()
}
