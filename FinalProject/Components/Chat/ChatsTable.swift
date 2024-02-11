//
//  ChatTsable.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 29.01.24.
//

import SwiftUI
import UIKit

struct ChatsTable: UIViewRepresentable, WithRootNavigationController {
    // MARK: - properties
    @ObservedObject var chatsViewModel: ChatsViewModel
    
    // MARK: - Methods
    func makeCoordinator() -> Coordinator {
        return Coordinator(chatsViewModel: chatsViewModel, didSelectHandler: push)
    }
    
    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = context.coordinator
        tableView.delegate = context.coordinator
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        uiView.reloadData()
    }
    
    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        @ObservedObject var chatsViewModel: ChatsViewModel
        
        // MARK: - Properties
        private var didSelectHandler: (UIViewController, Bool, Int?) -> Void
        
        // MARK: - Inits
        init(chatsViewModel: ChatsViewModel, didSelectHandler: @escaping (UIViewController, Bool, Int?) -> Void) {
            self.chatsViewModel = chatsViewModel
            self.didSelectHandler = didSelectHandler
        }
        
        // MARK: - Methods
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            chatsViewModel.chats.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let chat = chatsViewModel.chats[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.contentConfiguration = UIHostingConfiguration {
                ChatItem(chat: chat, chatsViewModel: chatsViewModel)
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let chat = chatsViewModel.chats[indexPath.row]
            
            let viewController = UIHostingController(rootView: ChatView(chatId: chat.id, participantId: nil))
            viewController.hidesBottomBarWhenPushed = true
            
            didSelectHandler(viewController, true, nil)
        }
    }
}

// MARK: - Preview
#Preview {
    ChatsTable(chatsViewModel: ChatsViewModel())
}
