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
    
    func creatUser(auth: AuthDataResultModel, fullName: String) async throws {
        let userData: [String:Any] = [
            "date_created" : Timestamp(),
            "email" : auth.email ?? "",
            "full_name" : fullName
        ]
         
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    func saveProfileImage(userId: String, imageUrl: String) async throws {
        let userData: [String:Any] = [
            "image_url" : imageUrl
        ]
        
        try await Firestore.firestore().collection("users").document(userId).setData(userData, merge: true)
    }
    
    func getUser(by userId: String) async throws -> UserModel? {
        let document = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        if document.exists {
            let dictionary = document.data()
            
            var user = UserModel(userId: userId, email: dictionary?["email"] as? String ?? "", fullName: dictionary?["full_name"] as? String ?? "")
            
            if let imageUrl =  dictionary?["image_url"] as? String {
                user.imageUrl = imageUrl
            }
            
            return user
        }
        
        return nil
    }
}
