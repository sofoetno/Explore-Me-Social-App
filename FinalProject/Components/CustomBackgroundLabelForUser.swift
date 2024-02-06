//
//  CustomBackgroundLabelForUser.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 16.01.24.
//

import SwiftUI

struct CustomBackgroundLabelForUser: View {
    // MARK: - Body
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(
                    Image("background1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                )
        }
        .ignoresSafeArea(.all)
        .offset(y: -600)
    }
}

// MARK: - Preview
#Preview {
    CustomBackgroundLabelForUser()
}
