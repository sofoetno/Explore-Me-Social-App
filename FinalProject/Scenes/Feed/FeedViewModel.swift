//
//  FeedViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

@MainActor
final class FeedViewModel: ObservableObject {
    @Published var posts: [String] = ["Erti", "Ori", "Sami", "otxi", "xuti", "jj", "ll"]
}
