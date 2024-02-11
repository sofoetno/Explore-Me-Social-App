//
//  FollowView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 02.02.24.
//

import SwiftUI

struct FollowView: View {
    // MARK: - Properties
    let userId: String
    @StateObject var profilePageViewModel = ProfilePageViewModel()
    @State var isFollowing: Bool = false
    
    // MARK: - Body
    var body: some View {
        Spacer()
        if isFollowing == true {
            Text("Following")
                .font(.callout)
        } else {
            Text("Followers")
                .font(.callout)
        }
        
        VStack {
            FollowTable(profilePageViewModel: profilePageViewModel)
        }
        .onAppear() {
            setup()
        }
    }
    
    // MARK: - Methods
    func setup() {
        profilePageViewModel.userId = userId
        Task {
            if isFollowing == true {
                try await profilePageViewModel.getFollowings()
            } else {
                try await profilePageViewModel.getFollowers()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    FollowView(userId: "Eu507agEdHMVyFOV2ldbggmq9xw1")
}
