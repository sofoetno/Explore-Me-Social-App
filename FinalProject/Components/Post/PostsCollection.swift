//
//  PostsCollection.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 31.01.24.
//

import SwiftUI
import UIKit

struct PostsCollection: UIViewRepresentable, WithRootNavigationController {
    // MARK: - Properties
    @ObservedObject var feedViewModel: FeedViewModel
    
    // MARK: - Methods
    func makeCoordinator() -> Coordinator {
        return Coordinator(feedViewModel: feedViewModel, didSelectHandler: push)
    }
    
    func makeUIView(context: Context) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = context.coordinator
        collectionView.delegate = context.coordinator
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.alwaysBounceVertical = true
        
        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        uiView.reloadData()
    }
    
    class Coordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        // MARK: - Properties
        @ObservedObject var feedViewModel: FeedViewModel
        private var didSelectHandler: (UIViewController, Bool, Int?) -> Void
        
        // MARK: - Inits
        init(feedViewModel: FeedViewModel, didSelectHandler: @escaping (UIViewController, Bool, Int?) -> Void) {
            self.feedViewModel = feedViewModel
            self.didSelectHandler = didSelectHandler
        }
        
        // MARK: - Methods
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            feedViewModel.posts.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let post = feedViewModel.posts[indexPath.row]
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            
            cell.contentConfiguration = UIHostingConfiguration {
                
                let numberOfItemsPerRow: CGFloat = 3
                let availableWidth = collectionView.frame.width
                let width = availableWidth / numberOfItemsPerRow - 2
                let height = width
                
                CustomAsyncImage(imageUrl: post.photoUrl ?? "")
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
            }
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let post = feedViewModel.posts[indexPath.row]
            
            didSelectHandler(UIHostingController(rootView: PostView(post: post, feedViewModel: feedViewModel)), true, nil)
        }
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let numberOfItemsPerRow: CGFloat = 3
            let availableWidth = collectionView.frame.width
            let width = availableWidth / numberOfItemsPerRow - 2
            let height = width
            
            return CGSize(width: width, height: height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 2
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 2
        }
    }
}

// MARK: - Preview
#Preview {
    PostsCollection(feedViewModel: FeedViewModel())
}

