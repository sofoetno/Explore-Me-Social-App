//
//  ChatView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 28.01.24.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var chatViewModel = ChatViewModel()
    let chatId: String 
    
    
    var body: some View {
        VStack {
            MessagesTable(chatViewModel: chatViewModel)
        }
        
        .safeAreaInset(edge: .bottom) {
            ZStack {
                TextField("Type here...", text: $chatViewModel.text)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 60)
                    .background(Color(red: 0.95, green: 0.96, blue: 0.97))
                    .cornerRadius(10)
                
                
                Button {
                    Task {
                        try await  chatViewModel.sendMessage()
                        try await chatViewModel.loadData()
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
            Task {
                print("test")
                try await chatViewModel.loadData()
            }
            
        }
    }
}

#Preview {
    ChatView(chatId: "d2nJDIUeecCeUztMp75n")
}
