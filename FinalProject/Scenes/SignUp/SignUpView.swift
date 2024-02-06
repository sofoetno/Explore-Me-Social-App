//
//  SignUpView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 15.01.24.
//

import SwiftUI
import Firebase

struct SignUpView: View, WithRootNavigationController {
    // MARK: - Properties
    @StateObject var signUpViewModel = SignUpAndLoginViewModel()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            CustomBackgroundLabelForUser()
            
            VStack(spacing: 20) {
                Text("Create your account")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                
                Spacer()
                
                fullNameTextField
                
                CustomTextFieldsForUser(signUpViewModel: signUpViewModel)
                
                Spacer()
                
                PasswordChecker(signUpViewModel: signUpViewModel)
                    .foregroundColor(.red)
                
                CustomSignUpButton(signUpViewModel: signUpViewModel)
                
                alreadyHaveAnAccount
                
                Spacer()
            }
            .padding()
        }
    }
    
    // MARK: - Computed properties
    var fullNameTextField: some View {
        TextField("Enter full name...", text: $signUpViewModel.fullName)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(red: 0.95, green: 0.96, blue: 0.97))
            .cornerRadius(30)
    }
    
    var alreadyHaveAnAccount: some View {
        HStack {
            Text("Already have an account?")
                .foregroundStyle(AppColors.darkGray)
            Button {
                goToLogin()
            } label: {
                Text("LOGIN")
                    .foregroundStyle(Color(red: 0.33, green: 0.33, blue: 0.79))
            }
        }
    }
    
    func goToLogin() {
        authNavigationController?.setViewControllers([UIHostingController(rootView: LoginView())], animated: false)
    }
}

// MARK: - Preview
#Preview {
    SignUpView()
}
