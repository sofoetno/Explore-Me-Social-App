//
//  LogoutButton.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 24.01.24.
//

import SwiftUI

struct LogoutButton: View, WithRootNavigationController {
    // MARK: - Body
    var body: some View {
        Button {
            AuthManager.shared.signOutUser()
            goToAuth()
        } label: {
            Capsule()
                .frame(width: 100, height: 40)
                .foregroundColor(.white)
                .overlay {
                    Text("LOG OUT")
                        .foregroundColor(Color(red: 0.53, green: 0.55, blue: 0.96))
                }
        }
    }
}

#Preview {
    LogoutButton()
}
