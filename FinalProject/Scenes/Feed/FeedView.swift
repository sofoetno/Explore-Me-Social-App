//
//  FeedView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct FeedView: View {
    @StateObject var feedViewModel = FeedViewModel()
    
    var body: some View {
        
        VStack(alignment: .trailing, spacing: 12) {
            Spacer()
            HStack {
                Image("mainLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170)
                    Spacer()
                FeedBar()
            }

                .padding(.horizontal, 12)
            PostsTable(feedViewModel: feedViewModel)
        }
        


        
        
    }
}

#Preview {
    FeedView()
}
