//
//  FeedBar.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct FeedBar: View, WithRootNavigationController {
    // MARK: - Properties
    @ObservedObject var feedViewModel: FeedViewModel
    @State var searchIsShown: Bool = false
    @State var searchTerm: String = ""
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .trailing, spacing: 10) {
            HStack(spacing: 20) {
                addPostButton
                
                startSearchButton
            }
            .font(.title)
            .foregroundColor(.gray)
            
            VStack() {
                if searchIsShown {
                    searchTextField
                    
                    searchButton
                }
            }
        }
    }
    
    // MARK: - Methods
    func openPostForm() {
        let rootView = PostFormView(feedViewModel: feedViewModel)
            .onDisappear() {
                Task {
                    await feedViewModel.fetchPosts()
                }
            }
        present(viewController: UIHostingController(rootView: rootView), animated: true, tab: 0)
    }
    
    // MARK: - Buttons
    var addPostButton: some View {
        Button {
            openPostForm()
        } label: {
            Image(systemName: "plus.circle")
        }
    }
    
    var startSearchButton: some View {
        Button {
            searchIsShown.toggle()
            Task {
                await feedViewModel.fetchPosts()
            }
        } label: {
            Image(systemName: "magnifyingglass")
        }
    }
    
    var searchButton: some View {
        Button {
            Task {
                await feedViewModel.fetchPosts(searchTerm: searchTerm)
            }
            
        } label: {
            Text("Search")
                .foregroundStyle(.purple)
        }
    }
    
    // MARK: - Computed properties
    var searchTextField: some View {
        TextField("search by title...", text: $searchTerm)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(red: 0.95, green: 0.96, blue: 0.97))
            .cornerRadius(30)
    }
}

// MARK: - Preview
#Preview {
    FeedBar(feedViewModel: FeedViewModel())
}
