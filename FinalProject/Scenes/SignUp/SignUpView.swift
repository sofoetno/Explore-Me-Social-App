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
                
                CustomTextFieldsForUser(signUpViewModel: signUpViewModel)
                Spacer()
                
                PasswordChecker(signUpViewModel: signUpViewModel)
                    .foregroundColor(.red)
                    .padding(.vertical, 40)
                
                CustomSignUpButton(signUpViewModel: signUpViewModel)
                
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
                Spacer()
                
            }
            .padding()
        }
        
    }
    
    func goToLogin() {
        self.push(viewController: UIHostingController(rootView: LoginView()), animated: true)
    }
}

// MARK: - Preview
#Preview {
    SignUpView()
}
