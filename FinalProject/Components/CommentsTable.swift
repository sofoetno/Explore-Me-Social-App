//
//  CommentsTable.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 22.01.24.
//

import SwiftUI
import UIKit

struct CommentsTable: UIViewRepresentable, WithRootNavigationController {
    @ObservedObject var commentViewModel: CommentViewModel
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(commentViewModel: commentViewModel)
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
        @ObservedObject var commentViewModel: CommentViewModel
        
        init(commentViewModel: CommentViewModel) {
            self.commentViewModel = commentViewModel
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            commentViewModel.comments.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let comment = commentViewModel.comments[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.contentConfiguration = UIHostingConfiguration {
               CommentItem(comment: comment)
            }
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

#Preview {
    CommentsTable(commentViewModel: CommentViewModel())
}
