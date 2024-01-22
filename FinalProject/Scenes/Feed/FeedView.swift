//
//  FeedView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct FeedView: View, WithRootNavigationController {
    @StateObject var feedViewModel = FeedViewModel()
    
    var body: some View {
        Button {
            AuthManager.shared.signOutUser()
            goToAuth()
        } label: {
            Text("Sign out!")
        }

        VStack(alignment: .trailing, spacing: 12) {
            Spacer()
            HStack {
                Image("mainLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170)
                    Spacer()
                FeedBar(feedViewModel: feedViewModel)
            }

                .padding(.horizontal, 12)
            PostsTable(feedViewModel: feedViewModel)
        }
    }
}

#Preview {
    FeedView()
}
