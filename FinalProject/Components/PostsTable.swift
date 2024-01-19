//
//  Feed.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 17.01.24.
//

import SwiftUI
import UIKit

struct PostsTable: UIViewRepresentable, WithRootNavigationController {
    @ObservedObject var feedViewModel: FeedViewModel
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(feedViewModel: feedViewModel, didSelectHandler: self.push)
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
        @ObservedObject var feedViewModel: FeedViewModel
        
        private var didSelectHandler: (UIViewController, Bool, Int) -> Void
        
        init(feedViewModel: FeedViewModel, didSelectHandler: @escaping (UIViewController, Bool, Int) -> Void) {
            self.feedViewModel = feedViewModel
            self.didSelectHandler = didSelectHandler
        }
        
        func tableView(_ collectionView: UITableView, numberOfRowsInSection section: Int) -> Int {
            feedViewModel.posts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let post = feedViewModel.posts[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.contentConfiguration = UIHostingConfiguration {
                PostItem(post: post)
            }
            cell.selectionStyle = .none
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let post = feedViewModel.posts[indexPath.row]
            
            didSelectHandler(UIHostingController(rootView: PostView(post: post)), true, 0)
        }
        
    }
}

#Preview {
    PostsTable(feedViewModel: FeedViewModel())
}
