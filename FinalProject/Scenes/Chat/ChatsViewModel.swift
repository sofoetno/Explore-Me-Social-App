//
//  ChatsViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 29.01.24.
//

import Foundation

@MainActor
final class ChatsViewModel: ObservableObject {
    @Published var chats: [ChatModel] = []
    
    func getChats() async throws {
        chats = try await ChatManager.shared.getChats()
        print(chats)
    }
    
    func getLatestMessage(by chatId: String) async throws -> MessageModel? {
        return try await MessageManager.shared.getLatestMessage(by: chatId)
    }
}


