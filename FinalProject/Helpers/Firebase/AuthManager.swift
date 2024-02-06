//
//  AuthManager.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 15.01.24.
//

import FirebaseAuth

struct AuthDataResultModel {
    // MARK: - Static properties
    let uid: String
    let email: String?
}

final class AuthManager {
    
    // MARK: - Properties
    static let shared = AuthManager()
    
    // MARK: - Methods
    @discardableResult
    func creatUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result = AuthDataResultModel(uid: authDataResult.user.uid, email: authDataResult.user.email)
        return result
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        let result = AuthDataResultModel(uid: authDataResult.user.uid, email: authDataResult.user.email)
        return result
    }
    
    func signOutUser() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    func getAuthenticatedUser() -> AuthDataResultModel? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        return AuthDataResultModel(uid: user.uid, email: user.email)
    }
}
