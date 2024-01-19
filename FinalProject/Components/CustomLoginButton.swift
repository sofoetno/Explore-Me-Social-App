//
//  CustomLoginButton.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 16.01.24.
//

import SwiftUI

struct CustomLoginButton: View, WithRootNavigationController {
    
    @ObservedObject var signUpViewModel: SignUpAndLoginViewModel
//    @State private var signUpSuccess = false
    @State private var showAlert = false
    
    var body: some View {
        Button {
            Task {
                let result = await signUpViewModel.login()
                switch result {
                case .success:
                    signUpViewModel.clearForm()
//                    signUpSuccess = true
//                    goToHome()
                    goToTab(tab: 0)
                    
                case .failure:
                    showAlert = true
                    signUpViewModel.clearForm()
                }
            }
        } label: {
            Text("Login")
                .font(.title2)
                .fontWeight(.semibold)
                
        }
        .primaryButtonStyle
    }
    
    func goToHome() {
        self.push(viewController: UIHostingController(rootView: FeedView()), animated: true)
    }
}

#Preview {
    CustomLoginButton(signUpViewModel: SignUpAndLoginViewModel())
}
