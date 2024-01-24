//
//  PostViewDropDownMenu.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 24.01.24.
//

import SwiftUI

struct PostViewDropDownMenu: View {
    var body: some View {
        Menu {
            Button("Edit") {
              
            }
            Button("Delete", role: .destructive) {
            }

        } label: {
            Label("Menu", systemImage: "slider.vertical.3")
                .foregroundColor(Color(red: 0.14, green: 0.14, blue: 0.14))
                .font(.title2)
                .padding(.horizontal, 12)
            
        }
    }
}

#Preview {
    PostViewDropDownMenu()
}
