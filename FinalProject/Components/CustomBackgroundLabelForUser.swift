//
//  CustomBackgroundLabelForUser.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 16.01.24.
//

import SwiftUI

struct CustomBackgroundLabelForUser: View {
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(
                    Image("background1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: .infinity)
                        .clipShape(Circle())
                )
        }
        .ignoresSafeArea(.all)
        .offset(y: -600)
    }
}

#Preview {
    CustomBackgroundLabelForUser()
}
