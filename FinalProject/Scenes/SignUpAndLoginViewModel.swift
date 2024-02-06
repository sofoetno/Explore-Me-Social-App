//
//  SignUpAnsLoginViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 15.01.24.
//

import Foundation
import SwiftUI

// MARK: - Enums
enum LoginError: Error {
    case missingCredentials
}

@MainActor
final class SignUpAndLoginViewModel: ObservableObject {
    // MARK: - Properties
    @Published var email = ""
    @Published var password = ""
    @Published var isEmailValid: Bool = false
    @Published var passwordStatus = PasswordValidationStatus()
    @Published var fullName: String = ""
    
    // MARK: - Methods
    func signUp() async -> Result<AuthDataResultModel, Error> {
        do {
            let userData = try await AuthManager.shared.creatUser(email: email, password: password)
            try await UserManager.shared.creatUser(auth: userData, fullName: fullName)
            return .success(userData)
        } catch {
            print(error)
            return .failure(error)
        }
    }
    
    func login() async -> Result<AuthDataResultModel, Error> {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password")
            return .failure(LoginError.missingCredentials)
        }
        
        do {
            let userData = try await AuthManager.shared.signInUser(email: email, password: password)
            return .success(userData)
        } catch {
            print(error)
            return .failure(error)
        }
    }
    
    func isFormValid() -> Bool {
        return isEmailValid && passwordStatus.isPasswordValid
    }
    
    func clearForm() {
        email = ""
        password = ""
    }
    
}
