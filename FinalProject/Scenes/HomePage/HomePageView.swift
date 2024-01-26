//
//  HomePageView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 16.01.24.
//

import SwiftUI

struct HomePageView: View, WithRootNavigationController {
    var body: some View {
        Text("Hello, World!")
        
        Button {
            goToFeed()
        } label: {
            Text("Go to feed")
        }
    }
    
    func goToFeed() {
        self.push(viewController: UIHostingController(rootView: FeedView()), animated: true, tab: 0)
    }
}

#Preview {
    HomePageView()
}
