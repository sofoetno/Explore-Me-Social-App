//
//  ChatListView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 29.01.24.
//

import SwiftUI

struct ChatListView: View {
    @StateObject var chatsViewModel = ChatsViewModel()
    
    var body: some View {
        VStack {
            ChatsTable(chatsViewModel: chatsViewModel)
        }
        .onAppear() {
            Task {
              try await chatsViewModel.getChats()
            }  
        }
    }
}

#Preview {
    ChatListView()
}
