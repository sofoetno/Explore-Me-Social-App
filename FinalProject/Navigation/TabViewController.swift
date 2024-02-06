//
//  TabViewController.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 19.01.24.
//

import UIKit
import SwiftUI

final class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Properties
        let feed = createNavigationController(title: "Home", image: UIImage(systemName: "house"), rootView: AnyView(FeedView()))
        let offers = createNavigationController(title: "Chats", image: UIImage(systemName: "message"), rootView: AnyView(ChatListView()))
        let profile = createNavigationController(title: "Profile", image: UIImage(systemName: "person"), rootView: AnyView(ProfilePageView(userId: AuthManager.shared.getAuthenticatedUser()?.uid ?? "")))
        
        setViewControllers([feed, offers, profile], animated: true)
    }
    
    // MARK: - Methods
    func createNavigationController(title: String, image: UIImage?, rootView: AnyView) -> UINavigationController {
        let rootViewController = UIHostingController(rootView: rootView)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
}
