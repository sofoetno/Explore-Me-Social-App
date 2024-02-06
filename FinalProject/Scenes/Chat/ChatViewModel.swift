//
//  ChatViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 28.01.24.
//

import Foundation

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var chat: ChatModel? = nil
    @Published var messages: [MessageModel] = []
    @Published var participant: UserModel? = nil
    @Published var text: String = ""
    @Published var authenticatedUser: UserModel?
    var chatId: String? = nil
    var participantId: String? = nil
    
    func loadData() async throws {
       
        if chat == nil && chatId != nil {
            chat = try await ChatManager.shared.getChatById(chatId: chatId ?? "")
        }
        try await getMessages()
        
        let participantIds = chat?.participants.filter({ userId in
            userId != AuthManager.shared.getAuthenticatedUser()?.uid
        })
        
        if participantIds?.count ?? 0 > 0 {
            participant = try await UserManager.shared.getUser(by: participantIds?[0] ?? "")
        }
        
        if let authUserId = AuthManager.shared.getAuthenticatedUser()?.uid {
            authenticatedUser = try await UserManager.shared.getUser(by: authUserId)
        }
    }
    
    func isAuthenticatedUser(userId: String) -> Bool {
        AuthManager.shared.getAuthenticatedUser()?.uid == userId
    }
    
    func sendMessage() async throws {
        try await MessageManager.shared.createMassage(message: MessageModel(
            text: text,
            chatId: chatId ?? "",
            senderId: AuthManager.shared.getAuthenticatedUser()?.uid ?? "",
            sendDate: nil))
    }
    
    func getMessages() async throws {
        messages = try await MessageManager.shared.getMessages(by: chatId ?? "")
    }
    
    func findOrCreateChat() async throws {
        chat = try await ChatManager.shared.getChatByParticipants(participantId: participantId ?? "")
       
        if chat == nil {
            chat = try await ChatManager.shared.createChat(participantId: participantId ?? "")
        }
        
        chatId = chat?.id
    }
}
