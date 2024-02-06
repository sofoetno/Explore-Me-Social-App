//
//  ChatManager.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 28.01.24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

final class ChatManager {
    static let shared = ChatManager()
    
    private init() { }
    
    func createChat(participantId: String) async throws -> ChatModel {
        let id = UUID().uuidString
        let participants = [participantId, AuthManager.shared.getAuthenticatedUser()?.uid ?? ""]
        let chatData: [String:Any] = [
            "participants" : participants
        ]
        
        try await Firestore.firestore().collection("chats").document(id).setData(chatData, merge: false)
        
        return ChatModel(id: id, participants: participants)
    }
    
    func getChatById(chatId: String) async throws -> ChatModel? {
        let document = try await Firestore.firestore().collection("chats").document(chatId).getDocument()
        
        if document.exists {
            let dictionary = document.data()
            
            let chat = ChatModel(id: chatId, participants: dictionary?["participants"] as! [String])
            
            return chat
        }
        return nil
    }
    
    
    
    func getChatByParticipants(participantId: String) async throws -> ChatModel? {
        let authenticatedUser = AuthManager.shared.getAuthenticatedUser()?.uid ?? ""
        let snapshot = try await Firestore.firestore()
            .collection("chats")
            .whereField("participants", in: [[authenticatedUser, participantId], [participantId, authenticatedUser]])
            .getDocuments()
        
        var chats: [ChatModel] = []
        
        snapshot.documents.forEach { document in
            let dictionary = document.data()
         
            let chat = ChatModel(id: document.documentID, participants: dictionary["participants"] as! [String])
            chats.append(chat)
        }
        
        return chats.count > 0 ? chats[0] : nil
    }
    
    func getChats() async throws -> [ChatModel] {
        let snapshot = try await Firestore.firestore()
            .collection("chats")
            .whereField("participants", arrayContains: AuthManager.shared.getAuthenticatedUser()?.uid ?? "")
            .getDocuments()
        
        var chats: [ChatModel] = []
        
        snapshot.documents.forEach { document in
            let dictionary = document.data()
         
            let chat = ChatModel(id: document.documentID, participants: dictionary["participants"] as! [String])
            chats.append(chat)
        }
        
        return chats
    }
}
