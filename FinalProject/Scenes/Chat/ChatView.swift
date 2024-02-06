//
//  ChatView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 28.01.24.
//

import SwiftUI

struct ChatView: View {
    @StateObject var chatViewModel = ChatViewModel()
    let chatId: String?
    let participantId: String?
   
    
    
    var body: some View {
        VStack {
            MessagesTable(chatViewModel: chatViewModel)
        }
        
        .safeAreaInset(edge: .bottom) {
            ZStack {
                TextField("Type as \(chatViewModel.authenticatedUser?.fullName ?? "")...", text: $chatViewModel.text)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 60)
                    .background(Color(red: 0.95, green: 0.96, blue: 0.97))
                    .cornerRadius(10)
                
                Button {
                    Task {
                        try await  chatViewModel.sendMessage()
                        try await chatViewModel.loadData()
                        chatViewModel.text = ""
                    }
                } label: {
                    Image(systemName: "arrow.right.circle")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                .offset(x: 140)
                
            }
            .padding(.horizontal, 12)
            .frame(height: 78)
        }
        .onAppear() {
            chatViewModel.chatId = chatId
            chatViewModel.participantId = participantId
            Task {
                if chatId == nil {
                    try await chatViewModel.findOrCreateChat()
                }
                try await chatViewModel.loadData()
            }
            
        }
    }
}

#Preview {
    ChatView(chatId: "6D5F3776-ABE3-489E-AA0E-98F674DDD13E", participantId: "3wAs5TDmywSnXs7KXuQ2i0WXQ2g1")
}
