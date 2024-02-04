//
//  FollowView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 02.02.24.
//

import SwiftUI

struct FollowView: View {
    @StateObject var profilePageViewModel = ProfilePageViewModel()
    let userId: String
    @State var isFollowing: Bool = false
    
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
}

#Preview {
    FollowView(userId: "Eu507agEdHMVyFOV2ldbggmq9xw1")
}
