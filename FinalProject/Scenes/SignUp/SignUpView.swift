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
    @ObservedObject private var signUpViewModel = SignUpViewModel()
    @State private var showAlert = false
    @State private var signUpSuccess = false
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(
                        Image("background1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: .infinity)
                            .clipShape(Circle())
                    )
            }
            .ignoresSafeArea(.all)
            .offset(y: -450)
            
            
            VStack(spacing: 20) {
                Text("Create your account")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                
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
                Spacer()
                
                // MARK: - Password chek
                VStack(alignment: .leading, spacing: 10) {
                    displayPasswordValidation(title: "Uppercase", conditation: signUpViewModel.passwordStatus.containsUppercase)
                    
                    displayPasswordValidation(title: "Lowercase", conditation: signUpViewModel.passwordStatus.containsLowercase)
                    
                    displayPasswordValidation(title: "Numbers", conditation: signUpViewModel.passwordStatus.containsNumber)
                    
                    displayPasswordValidation(title: "Symbols(?#@...)", conditation: signUpViewModel.passwordStatus.containsSymbol)
                    
                    displayPasswordValidation(title: "Min 8 characters", conditation: signUpViewModel.passwordStatus.passwordLength)
                    
                }
                .foregroundColor(.red)
                .padding(.vertical, 40)
                
                Button {
                    Task {
                        let result = await signUpViewModel.signUp()
                        switch result {
                        case .success:
                            print("")
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
                
                HStack {
                    Text("Already have an account?")
                    Button {
                        goToLogin()
                    } label: {
                        Text("SIGN IN")
                            .foregroundStyle(Color(red: 0.33, green: 0.33, blue: 0.79))
                    }
                }
                Spacer()
                
            }
            
            .padding()
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
    
    
    func goToLogin() {
        self.push(viewController: UIHostingController(rootView: SignInview()), animated: true)
    }
    
}

// MARK: - Preview
#Preview {
    SignUpView()
}
