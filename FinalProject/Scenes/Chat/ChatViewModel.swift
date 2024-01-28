//
//  ChatViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 28.01.24.
//

import Foundation

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var chat: [ChatModel] = []
    @Published var messages: [MessageModel] = [MessageModel(text: "Google Messages is a text messaging software application developed by Google for its Android and Wear OS mobile operating systems, while it's also available via the Web. Google's official universal messaging platform for the Android ecosystem, Messages employs SMS and Rich Communication Services. ", chatId: "1", senderId: "1", sendDate: nil)]
    @Published var user: [UserModel] = []
    @Published var text: String = ""
}
