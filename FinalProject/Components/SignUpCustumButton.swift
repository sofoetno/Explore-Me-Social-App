//
//  SignUpCustumButton.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 16.01.24.
//

import SwiftUI

struct SignUpCustumButton: View {
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
}

#Preview {
    SignUpCustumButton(signUpViewModel: SignUpAndLoginViewModel())
}
