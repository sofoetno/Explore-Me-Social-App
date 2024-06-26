//
//  MessagesTable.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 28.01.24.
//


import SwiftUI
import UIKit

struct MessagesTable: UIViewRepresentable, WithRootNavigationController {
    // MARK: - Properties
    @ObservedObject var chatViewModel: ChatViewModel
    
    // MARK: - Methods
    func makeCoordinator() -> Coordinator {
        return Coordinator(chatViewModel: chatViewModel)
    }
    
    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = context.coordinator
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        uiView.reloadData()
    }
    
    class Coordinator: NSObject, UITableViewDataSource {
        // MARK: - Properties
        @ObservedObject var chatViewModel: ChatViewModel
        
        // MARK: - Inits
        init(chatViewModel: ChatViewModel) {
            self.chatViewModel = chatViewModel
        }
        
        // MARK: - Methods
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            chatViewModel.messages.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let message = chatViewModel.messages[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.contentConfiguration = UIHostingConfiguration {
                MessageItem(message: message, chatViewModel: chatViewModel)
            }
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

// MARK: - Preview
#Preview {
    MessagesTable(chatViewModel: ChatViewModel())
}

