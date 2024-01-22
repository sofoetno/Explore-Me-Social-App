//
//  CustomTextFieldsForUser.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 16.01.24.
//

import SwiftUI

struct CustomTextFieldsForUser: View {
    @ObservedObject var signUpViewModel: SignUpAndLoginViewModel
    
    var body: some View {
        TextField("Enter your email...", text: $signUpViewModel.email)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(red: 0.95, green: 0.96, blue: 0.97))
            .cornerRadius(30)
        
        SecureField("Password", text: $signUpViewModel.password)
            .onChange(of: signUpViewModel.password) { oldValue, newValue in
                
                signUpViewModel.passwordStatus = Validator.validatePassword(password: newValue)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(red: 0.95, green: 0.96, blue: 0.97))
            .cornerRadius(30)
    }
}

#Preview {
    CustomTextFieldsForUser(signUpViewModel: SignUpAndLoginViewModel())
}
