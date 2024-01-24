//
//  ProfilePageDropDownMenu.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 24.01.24.
//

import SwiftUI

struct ProfilePageDropDownMenu: View, WithRootNavigationController {
    var body: some View {
        Menu {
            Button("Sign Out"){
                AuthManager.shared.signOutUser()
                goToAuth()
            }
            Button("Delete", role: .destructive) {
                
            }
        } label: {
            Label("Settings", systemImage: "gearshape")
                .font(.title)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ProfilePageDropDownMenu()
}
