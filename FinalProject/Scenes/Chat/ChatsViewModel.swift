//
//  ChatsViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 29.01.24.
//

import Foundation

@MainActor
final class ChatsViewModel: ObservableObject {
    // MARK: - Properties
    @Published var chats: [ChatModel] = []
    
    // MARK: - Methods
    func getChats() async throws {
        chats = try await ChatManager.shared.getChats()
    }
    
    func getLatestMessage(by chatId: String) async throws -> MessageModel? {
        do {
            return try await MessageManager.shared.getLatestMessage(by: chatId)
        } catch {
            print(error)
        }
        return nil 
    }
}


