//
//  LoginWithGoogleAndFb.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 16.01.24.
//

import SwiftUI

struct LoginWithGoogleAndFb: View {
    var body: some View {
        
        VStack {
            Text("OR LOGIN BY")
            .foregroundStyle(AppColors.darkGray)
            .font(.title2)
            
            HStack(spacing: 28) {
                Button {
                    
                } label: {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(red: 0.89, green: 0.89, blue: 0.99))
                        .overlay(Image("facebook"))
                }
                
                Button {
                    
                } label: {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(red: 0.89, green: 0.89, blue: 0.99))
                        .overlay(Image("google"))
                }
                
            }
        }
            
    }
}

#Preview {
    LoginWithGoogleAndFb()
}
