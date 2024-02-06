//
//  MessageManager.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 28.01.24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

final class MessageManager {
    static let shared = MessageManager()
    
    private init() { }
    
    func createMassage(message: MessageModel) async throws {
        let id = UUID().uuidString
        let messageData: [String:Any] = [
            "sender_id" : AuthManager.shared.getAuthenticatedUser()?.uid ?? "",
            "chat_id" : message.chatId,
            "text" : message.text,
            "send_date" : Timestamp()
        ]
        
        try await Firestore.firestore().collection("messages").document(id).setData(messageData, merge: false)
    }
    
    func getMessages(by chatId: String) async throws -> [MessageModel] {
        let snapshot = try await Firestore.firestore()
            .collection("messages")
            .whereField("chat_id", isEqualTo: chatId)
            .order(by: "send_date")
            .getDocuments()
        
        var messages: [MessageModel] = []
        
        snapshot.documents.forEach { document in
            
            let dictionary = document.data()
            let created = dictionary["send_date"] as! Timestamp
            let sendDate = created.dateValue()
            
            let message = MessageModel(
                text: dictionary["text"] as! String,
                chatId: dictionary["chat_id"] as! String,
                senderId: dictionary["sender_id"] as! String,
                sendDate: sendDate)
            messages.append(message)
        }
        
        return messages
    }
    
    func getLatestMessage(by chatId: String) async throws -> MessageModel? {
        let snapshot = try await Firestore.firestore()
            .collection("messages")
            .whereField("chat_id", isEqualTo: chatId)
            .order(by: "send_date", descending: true)
            .limit(to: 1)
            .getDocuments()
        
        var messages: [MessageModel] = []
        
        snapshot.documents.forEach { document in
            let dictionary = document.data()
            
            let created = dictionary["send_date"] as! Timestamp
            let sendDate = created.dateValue()
            
            let message = MessageModel(
                text: dictionary["text"] as! String,
                chatId: dictionary["chat_id"] as! String,
                senderId: dictionary["sender_id"] as! String,
                sendDate: sendDate
            )
            messages.append(message)
        }
        
        return messages.count > 0 ? messages[0] : nil
    }
}
