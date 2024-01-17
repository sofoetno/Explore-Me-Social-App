//
//  CustomSignUpButton.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 16.01.24.
//

import SwiftUI

struct CustomSignUpButton: View, WithRootNavigationController {
    @ObservedObject var signUpViewModel: SignUpAndLoginViewModel
    @State private var signUpSuccess = false
    @State private var showAlert = false
    
    var body: some View {
        Button {
            Task {
                let result = await signUpViewModel.signUp()
                switch result {
                case .success:
                    signUpViewModel.clearForm()
                    registrationSuccsess()
                    signUpSuccess = true
                    
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
        self.push(viewController: UIHostingController(rootView: CustomSignUpAnimation()), animated: true)
    }
}

#Preview {
    CustomSignUpButton(signUpViewModel: SignUpAndLoginViewModel())
}
