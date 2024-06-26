//
//  CustomLoginButton.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 16.01.24.
//

import SwiftUI

struct CustomLoginButton: View, WithRootNavigationController {
    
    @ObservedObject var signUpViewModel: SignUpAndLoginViewModel
    @State private var showAlert = false
    
    var body: some View {
        Button {
            Task {
                let result = await signUpViewModel.login()
                switch result {
                case .success:
                    signUpViewModel.clearForm()
                    goToHome()
                    
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
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Somethin went wrong"),
                  message: Text("Please check your email or password."),
                  dismissButton: .default(Text("OK"))
            )
        })
    }
    
    func goToHome() {
        goToTab(tab: 0)
    }
}

#Preview {
    CustomLoginButton(signUpViewModel: SignUpAndLoginViewModel())
}
