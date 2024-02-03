//
//  WithRootNavigationController.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 15.01.24.
//

import UIKit
import SwiftUI

protocol WithRootNavigationController {
    // MARK: - Properties
    var authNavigationController: AuthNavigationController? { get }
    
    // MARK: - Methods
    func push(viewController: UIViewController, animated: Bool, tab: Int?)
    func pop(animated: Bool, tab: Int?)
}

extension WithRootNavigationController where Self:View {
    
    // MARK: - Properties
    var authNavigationController: AuthNavigationController? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = scene as? UIWindowScene,
              let authNavigationController = sceneDelegate.windows.first?.rootViewController as? AuthNavigationController
        else { return nil }
        
        return authNavigationController
    }
    
    // MARK: - Methods
    func push(viewController: UIViewController, animated: Bool, tab: Int? = nil) {
        if let navigationController = getNavigationController(tab: tab) {
            navigationController.pushViewController(viewController, animated: animated)
        }
    }
    
    func pop(animated: Bool, tab: Int? = nil) {
        if let navigationController = getNavigationController(tab: tab) {
            navigationController.popViewController(animated: animated)
        }
    }
    
    func present(viewController: UIViewController, animated: Bool, tab: Int? = nil) {
        if let navigationController = getNavigationController(tab: tab) {
            navigationController.present(viewController, animated: animated)
        }
    }
    
    func dismiss(animated: Bool, tab: Int? = nil) {
        if let navigationController = getNavigationController(tab: tab) {
            navigationController.dismiss(animated: animated)
        }
    }
    
    func goToAuth() {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = scene as? UIWindowScene,
              let window = sceneDelegate.windows.first
        else {
            return
        }
        
        let rootViewController = UIHostingController(rootView: LoginView())
        let navigationController = AuthNavigationController(rootViewController: rootViewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
    
    func goToTab(tab: Int) {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = scene as? UIWindowScene,
              let window = sceneDelegate.windows.first
        else {
            return
        }
        
        if let tabViewController = window.rootViewController as? UITabBarController {
            tabViewController.selectedIndex = tab
        } else {
            window.rootViewController = TabViewController()
            window.makeKeyAndVisible()
        }
    }
    
    private func getNavigationController(tab: Int? = nil) -> UINavigationController? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = scene as? UIWindowScene,
              let tabViewController = sceneDelegate.windows.first?.rootViewController as? UITabBarController
        else { return nil }
        
        let rootNavigationController = tabViewController.viewControllers?[tab ?? tabViewController.selectedIndex] as? UINavigationController
        return rootNavigationController
    }
}
