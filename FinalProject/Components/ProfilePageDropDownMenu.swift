//
//  ProfilePageDropDownMenu.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 24.01.24.
//

import SwiftUI

struct ProfilePageDropDownMenu: View, WithRootNavigationController {
    // MARK: - Body
    var body: some View {
        Menu {
            Button("Sign Out"){
                AuthManager.shared.signOutUser()
                goToAuth()
            }
        } label: {
            Label("Settings", systemImage: "gearshape")
                .font(.title2)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ProfilePageDropDownMenu()
}
