//
//  CommentsTable.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 22.01.24.
//

import SwiftUI
import UIKit

struct CommentsTable: UIViewRepresentable, WithRootNavigationController {
    // MARK: - Properties
    @ObservedObject var commentViewModel: CommentViewModel
    
    // MARK: - Methods
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
        // MARK: - Properties
        @ObservedObject var commentViewModel: CommentViewModel
        
        // MARK: - Inits
        init(commentViewModel: CommentViewModel) {
            self.commentViewModel = commentViewModel
        }
        
        // MARK: - Methods
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

// MARK: - Preview
#Preview {
    CommentsTable(commentViewModel: CommentViewModel())
}
