//
//  ProfileItemViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 30.01.24.
//

import Foundation

@MainActor
final class ProfileItemViewModel: ObservableObject {
    @Published var userId: String = ""
    @Published var currentProfileImageUrl: String = ""
    @Published var fullName: String = ""
    
    func getUser() async throws {
        do {
            let user = try await UserManager.shared.getUser(by: userId)
            currentProfileImageUrl = user?.imageUrl ?? ""
            fullName = user?.fullName ?? ""
        } catch {
            print(error)
        }
       
    }
    
    func getParticipantIdFromChat(chat: ChatModel) -> String? {
        let participantIds = chat.participants.filter({ userId in
            userId != AuthManager.shared.getAuthenticatedUser()?.uid
        })
        
        if participantIds.count > 0 {
            return participantIds[0]
        } else {
            return nil
        }
    }
}
