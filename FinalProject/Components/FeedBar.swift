//
//  FeedBar.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct FeedBar: View {
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "plus.circle")
            Image(systemName: "message")
            Image(systemName: "magnifyingglass")
        }
        .font(.title)
        .foregroundColor(.gray)

    }
}

#Preview {
    FeedBar()
}
