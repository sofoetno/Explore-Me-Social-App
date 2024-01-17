//
//  LoginView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 15.01.24.
//

import SwiftUI

struct LoginView: View, WithRootNavigationController {
    
    // MARK: - Properties
    @ObservedObject private var signUpViewModel = SignUpAndLoginViewModel()
    
    var body: some View {
        ZStack {
            CustomBackgroundLabelForUser()
            VStack(spacing: 20) {
                
                Text("Welcome back")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                
                CustomTextFieldsForUser(signUpViewModel: signUpViewModel)
                Spacer()
                
                CustomLoginButton(signUpViewModel: signUpViewModel)

                
                LoginWithGoogleAndFb()
                    .padding(.vertical, 24)

                notHaveaccount
            }
            .padding()
            
        }
    }
    
    var notHaveaccount: some View {
        HStack {
            Text("Don't have account?")
                .foregroundStyle(AppColors.darkGray)
            Button {
                goToSignUp()
            } label: {
                Text("Sign Up")
                    .foregroundStyle(Color(red: 0.33, green: 0.33, blue: 0.79))
            }
        }
    }
    
    func goToSignUp() {
        self.push(viewController: UIHostingController(rootView: SignUpView()), animated: true)
    }
}

#Preview {
    LoginView()
}
