//
//  ChatItem.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 29.01.24.
//

import SwiftUI

struct ChatItem: View {
    
    let chat: ChatModel
    @ObservedObject var chatsViewModel: ChatsViewModel
    @State var latestMessage: MessageModel? = nil
    
    var body: some View {
        HStack(spacing: 20) {
            Image("avatar2")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding()
            VStack {
                Text("Name FullName")
                    .fontWeight(.semibold)
                Text(latestMessage?.text ?? "")
                    .foregroundStyle(.gray)
            }
            
            .padding(.horizontal, 65)
            
        }
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.07, green: 0.06, blue: 0.09).opacity(0), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.07, green: 0.06, blue: 0.09).opacity(0.51), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0, y: 0.72),
                endPoint: UnitPoint(x: 1.3, y: 0.75)
            )
        )
        .cornerRadius(18)
        .padding(.vertical, 50)
        .onAppear() {
            Task {
                latestMessage = try await chatsViewModel.getLatestMessage(by: chat.id)
            }
        }
    }
}

#Preview {
    ChatItem(chat: ChatModel(id: "", participants: [""]), chatsViewModel: ChatsViewModel())
}
