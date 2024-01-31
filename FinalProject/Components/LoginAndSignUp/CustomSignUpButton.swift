//
//  CustomSignUpButton.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 16.01.24.
//

import SwiftUI

struct CustomSignUpButton: View, WithRootNavigationController {
    @ObservedObject var signUpViewModel: SignUpAndLoginViewModel
    @State private var showAlert = false
    
    var body: some View {
        Button {
            Task {
                let result = await signUpViewModel.signUp()
                switch result {
                case .success:
                    signUpViewModel.clearForm()
                    registrationSuccsess()
                    
                case .failure:
                    showAlert = true
                    signUpViewModel.clearForm()
                }
            }
        } label: {
            Text("Sign Up by Email")
        }
        .primaryButtonStyle
    }
    
    func registrationSuccsess() {
        authNavigationController?.pushViewController(UIHostingController(rootView: CustomSignUpAnimation()), animated: true)
    }
}

#Preview {
    CustomSignUpButton(signUpViewModel: SignUpAndLoginViewModel())
}
