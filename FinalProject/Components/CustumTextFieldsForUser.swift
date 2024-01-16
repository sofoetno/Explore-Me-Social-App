//
//  CustumTextFieldsForUser.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 16.01.24.
//

import SwiftUI

struct CustumTextFieldsForUser: View {
    @ObservedObject var signUpViewModel: SignUpAndLoginViewModel
    
    var body: some View {
        TextField("enter your Email...", text: $signUpViewModel.email)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .frame(width: .infinity, alignment: .leading)
            .background(Color(red: 0.95, green: 0.96, blue: 0.97))
            .cornerRadius(30)
        
        SecureField("Password", text: $signUpViewModel.password)
            .onChange(of: signUpViewModel.password) { oldValue, newValue in
                
                signUpViewModel.passwordStatus = Validator.validatePassword(password: newValue)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .frame(width: .infinity, alignment: .leading)
            .background(Color(red: 0.95, green: 0.96, blue: 0.97))
            .cornerRadius(30)
    }
}

#Preview {
    CustumTextFieldsForUser(signUpViewModel: SignUpAndLoginViewModel())
}
