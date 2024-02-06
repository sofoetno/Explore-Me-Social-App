//
//  FollowItem.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 01.02.24.
//

import SwiftUI

struct FollowItem: View, WithRootNavigationController {
    
//    let user: UserModel
    let userId: String
    @StateObject var profileItemViewModel = ProfileItemViewModel()

    var body: some View {
        HStack(spacing: 10) {
            CustomAsyncImage(imageUrl: profileItemViewModel.currentProfileImageUrl)
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 44, height: 44)
                .onTapGesture {
                    push(viewController: UIHostingController(rootView: ProfilePageView(userId: profileItemViewModel.userId)), animated: true)
                    dismiss(animated: true)
                }
            
            Text(profileItemViewModel.fullName)
            Spacer()
        }
        .onAppear() {
            print("userId: \(userId)")
            profileItemViewModel.userId = userId
            Task {
               try await profileItemViewModel.getUser()
            }

        }

    }
}

#Preview {
    FollowItem(userId: "3wAs5TDmywSnXs7KXuQ2i0WXQ2g1")
}
