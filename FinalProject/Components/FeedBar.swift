//
//  FeedBar.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct FeedBar: View, WithRootNavigationController {
    @ObservedObject var feedViewModel: FeedViewModel
    @State var searchIsShown: Bool = false
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 10) {
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
                    searchIsShown.toggle()
                    Task {
                        await feedViewModel.fetchPosts()
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
            .font(.title)
            .foregroundColor(.gray)
            
            VStack() {
                if searchIsShown {
                    TextField("search...", text: $feedViewModel.searchTerm)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(Color(red: 0.95, green: 0.96, blue: 0.97))
                        .cornerRadius(30)
                    
                    Button {
                        Task {
                            await feedViewModel.fetchPosts()
                        }
                        
                    } label: {
                        Text("Search")
                            .foregroundStyle(.purple)
                    }
                }
            }
        }
        
      
    }
    
    func openPostForm() {
        present(viewController: UIHostingController(rootView: PostFormView(feedViewModel: feedViewModel)), animated: true, tab: 0)
        
    }
}

#Preview {
    FeedBar(feedViewModel: FeedViewModel())
}
