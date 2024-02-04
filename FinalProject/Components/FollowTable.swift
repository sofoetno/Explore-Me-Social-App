//
//  FollowTable.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 01.02.24.
//

import SwiftUI
import UIKit

struct FollowTable: UIViewRepresentable, WithRootNavigationController {
    @ObservedObject var profilePageViewModel: ProfilePageViewModel
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(profilePageViewModel: profilePageViewModel)
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
        @ObservedObject var profilePageViewModel: ProfilePageViewModel
        
        init(profilePageViewModel: ProfilePageViewModel) {
            self.profilePageViewModel = profilePageViewModel
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            profilePageViewModel.followList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let followerId = profilePageViewModel.followList[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.contentConfiguration = UIHostingConfiguration {
                FollowItem(userId: followerId)
            }
            
            return cell
        }
    }
}

#Preview {
    FollowTable(profilePageViewModel: ProfilePageViewModel())
}
