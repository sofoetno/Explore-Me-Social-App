//
//  MessageItem.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 29.01.24.
//

import SwiftUI

struct MessageItem: View {
    let message: MessageModel
    
    var body: some View {
        VStack {
            Text(message.text)
                .overlay(
                    Image("avatar")
                        .resizable()
                        .clipShape(Circle())
                        .scaledToFit()
                        .frame(width: 34, height: 34)
                        .offset(x: -154, y: 110)
                        
                )
                .padding()
               
        }
        .frame(width: 350)
        .fontDesign(.serif)
        .background(AppColors.silver)


    }
}

#Preview {
    MessageItem(message: MessageModel(text: "Google Messages is a text messaging software application developed by Google for its Android and Wear OS mobile operating systems, while it's also available via the Web. Google's official universal messaging platform for the Android ecosystem, Messages employs SMS and Rich Communication Services.", chatId: "2", senderId: "3", sendDate: nil))
}
