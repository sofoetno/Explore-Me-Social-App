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
    @Published var messages: [MessageModel] = [MessageModel(text: "Google Messages is a text messaging software application developed by Google for its Android and Wear OS mobile operating systems, while it's also available via the Web. Google's official universal messaging platform for the Android ecosystem, Messages employs SMS and Rich Communication Services. ", chatId: "1", senderId: "1", sendDate: nil)]
    @Published var participant: UserModel? = nil
    @Published var text: String = ""
    var chatId: String? = nil
    
    func loadData() async throws {
       
        chat = try await ChatManager.shared.getChatById(chatId: chatId ?? "")
        try await getMessages()
        
        let participantIds = chat?.participants.filter({ userId in
            userId != AuthManager.shared.getAuthenticagedUser()?.uid
        })
        
        if participantIds?.count ?? 0 > 0 {
            participant = try await UserManager.shared.getUser(by: participantIds?[0] ?? "")
        }
    }
    
    func isAuthenticatedUser(userId: String) -> Bool {
        AuthManager.shared.getAuthenticagedUser()?.uid == userId
    }
    
    func sendMessage() async throws {
        try await MessageManager.shared.createMassage(message: MessageModel(
            text: text,
            chatId: chatId ?? "",
            senderId: AuthManager.shared.getAuthenticagedUser()?.uid ?? "",
            sendDate: nil))
    }
    
    func getMessages() async throws {
        messages = try await MessageManager.shared.getMessages(by: chatId ?? "")
    }
}
