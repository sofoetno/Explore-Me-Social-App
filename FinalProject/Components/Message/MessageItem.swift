//
//  MessageItem.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 29.01.24.
//

import SwiftUI

struct MessageItem: View {
    let message: MessageModel
    @ObservedObject var chatViewModel: ChatViewModel
    
    var body: some View {
        
        if chatViewModel.isAuthenticatedUser(userId: message.senderId) {
            VStack {
                HStack(alignment: .bottom){
                    CustomAsyncImage(imageUrl: chatViewModel.authenticatedUser?.imageUrl ?? "")
                        .clipShape(Circle())
                        .scaledToFill()
                        .frame(width: 44, height: 44)
                    
                    Spacer()
                    
                    HStack {
                        Text(message.text)
                        
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(.purple)
                    .cornerRadius(20)
                    .offset(x: -10)
                }
                
                
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
            .fontDesign(.serif)
        } else {
            VStack {
                HStack(alignment: .bottom){
                    HStack {
                        Text(message.text)
                    }
                    .padding()
                    .background(AppColors.customRed)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .offset(x: 10)
                    
                    Spacer()
                    
                    CustomAsyncImage(imageUrl: chatViewModel.participant?.imageUrl ?? "")
                        .clipShape(Circle())
                        .scaledToFill()
                        .frame(width: 44, height: 44)
                }
                
                
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
            .fontDesign(.serif)
        }
        
    }
}

#Preview {
    MessageItem(message: MessageModel(text: "Google Messages is a text messaging software application developed by Google for its Android and Wear OS mobile operating systems, while it's also available via the Web. Google's official universal messaging platform for the Android ecosystem, Messages employs SMS and Rich Communication Services.", chatId: "0554B0B1-BC8F-4E6D-B292-6E393C999B14", senderId: "3", sendDate: nil), chatViewModel: ChatViewModel())
}
