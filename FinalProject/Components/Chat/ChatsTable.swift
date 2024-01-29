//
//  ChatTsable.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 29.01.24.
//

import SwiftUI
import UIKit

import SwiftUI
import UIKit

struct ChatsTable: UIViewRepresentable, WithRootNavigationController {
    @ObservedObject var chatsViewModel: ChatsViewModel
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(chatsViewModel: chatsViewModel)
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
        @ObservedObject var chatsViewModel: ChatsViewModel
        
        init(chatsViewModel: ChatsViewModel) {
            self.chatsViewModel = chatsViewModel
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            chatsViewModel.chats.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let chat = chatsViewModel.chats[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.contentConfiguration = UIHostingConfiguration {
                ChatItem(chat: chat, chatsViewModel: chatsViewModel)
            }
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

#Preview {
    ChatsTable(chatsViewModel: ChatsViewModel())
}
