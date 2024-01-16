//
//  PasswordChecker.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 16.01.24.
//

import SwiftUI

struct PasswordChecker: View {
    @ObservedObject var signUpViewModel: SignUpAndLoginViewModel
    
    var body: some View {
        // MARK: - Password chek
        VStack(alignment: .leading, spacing: 10) {
            displayPasswordValidation(title: "Uppercase", conditation: signUpViewModel.passwordStatus.containsUppercase)
            
            displayPasswordValidation(title: "Lowercase", conditation: signUpViewModel.passwordStatus.containsLowercase)
            
            displayPasswordValidation(title: "Numbers", conditation: signUpViewModel.passwordStatus.containsNumber)
            
            displayPasswordValidation(title: "Symbols(?#@...)", conditation: signUpViewModel.passwordStatus.containsSymbol)
            
            displayPasswordValidation(title: "Min 8 characters", conditation: signUpViewModel.passwordStatus.passwordLength)
        }
    }
    
    // MARK: - Methods
    func displayPasswordValidation(title: String, conditation: Bool) -> some View {
        HStack {
        Image(systemName: conditation ? "checkmark.seal" : "x.square")
                .foregroundColor(conditation ? .green : .red)
            Text(title)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    PasswordChecker(signUpViewModel: SignUpAndLoginViewModel())
}
