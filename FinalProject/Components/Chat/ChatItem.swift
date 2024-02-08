//
//  ChatItem.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 29.01.24.
//

import SwiftUI

struct ChatItem: View {
    
    let chat: ChatModel
    // MARK: - properties
    @ObservedObject var chatsViewModel: ChatsViewModel
    @State var latestMessage: MessageModel? = nil
    @StateObject var profileItemViewModel = ProfileItemViewModel()
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 20) {
            CustomAsyncImage(imageUrl: profileItemViewModel.currentProfileImageUrl)
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 40, height: 40)
                .padding(.horizontal, 10)
            VStack {
                Text(profileItemViewModel.fullName)
                    .fontWeight(.semibold)
                Text(latestMessage?.text ?? "")
                    .foregroundStyle(AppColors.darkGray)
            }
            .frame(width: 280, height: 56)
            
        }
        .background(backgroundColor)
        .cornerRadius(18)
        .onAppear() {
            profileItemViewModel.userId = profileItemViewModel.getParticipantIdFromChat(chat: chat) ?? ""
            Task {
                latestMessage = try await chatsViewModel.getLatestMessage(by: chat.id)
                try await profileItemViewModel.getUser()
            }
        }
    }
    
    // MARK: - Computed properties
    var backgroundColor: some View {
        LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.horizontal)
            .opacity(0.5)
    }
}

// MARK: - preview
#Preview {
    ChatItem(chat: ChatModel(id: "0554B0B1-BC8F-4E6D-B292-6E393C999B14", participants: ["Eu507agEdHMVyFOV2ldbggmq9xw1", "rCiONGhVw7cFPWPh1gEdOGX6GXT2"]), chatsViewModel: ChatsViewModel())
}
