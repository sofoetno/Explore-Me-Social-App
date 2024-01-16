//
//  AuthManager.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 15.01.24.
//

import FirebaseAuth

struct AuthDataResultModel {
    // MARK: - Properties
    let uid: String
    let email: String?
}


final class AuthManager {

    static let shared = AuthManager()
    
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
    

}
