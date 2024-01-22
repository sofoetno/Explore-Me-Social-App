//
//  UserManager.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 21.01.24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    func creatUser(auth: AuthDataResultModel) async throws {
        let userData: [String:Any] = [
            "user_id" : auth.uid,
            "date_created" : Timestamp(),
            "email" : auth.email ?? ""
        ]
         
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
}
