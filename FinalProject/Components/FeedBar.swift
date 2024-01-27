//
//  FeedBar.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct FeedBar: View, WithRootNavigationController {
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                openPostForm()
            } label: {
                Image(systemName: "plus.circle")
            }
            
            Button {
                
            } label: {
                Image(systemName: "message")
            }
            
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
            }
        }
        .font(.title)
        .foregroundColor(.gray)
    }
    
    func openPostForm() {
        present(viewController: UIHostingController(rootView: PostFormView(feedViewModel: feedViewModel)), animated: true, tab: 0)
        
    }
}

#Preview {
    FeedBar(feedViewModel: FeedViewModel())
}
