//
//  SignInView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 15.01.24.
//

import SwiftUI

struct SignInview: View, WithRootNavigationController {
    var body: some View {
        Button {
           goToLogin()
        } label: {
            Text("Sign in")
        }
    }
    
    func goToLogin() {
        self.push(viewController: UIHostingController(rootView: SignUpView()), animated: true)
    }
}

#Preview {
    SignInview()
}
