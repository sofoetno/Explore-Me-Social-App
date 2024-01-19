//
//  ProfilePage.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 19.01.24.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        ZStack {
            CustomBackgroundLabelForUser()
            
            
            Button {
                
            } label: {
                Capsule()
                    .frame(width: 80, height: 40)
                    .foregroundColor(.white)
                    .overlay(
                        Text("Follow")
                            .foregroundColor(Color(red: 0.53, green: 0.55, blue: 0.96))
                    )
                    .offset(x: 126, y: -340)
                    
            }
            
            VStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100)

               
                    .overlay(
                        Image("profilaImage")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .cornerRadius(6)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    )
            }
            .offset(y: -220)
            
            VStack {
                Text("Bruno Mars")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("Georgia, Tbilisi")
                    .foregroundStyle(Color.gray)
                
                HStack(alignment: .center, spacing: 48) {
                    Text("220 Followers")
                        .kerning(0.6)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.14, green: 0.14, blue: 0.14))
                    
                    Text("150 Following")
                        .kerning(0.6)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.14, green: 0.14, blue: 0.14))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .frame(width: 347, alignment: .center)
                .background(Color(red: 0.96, green: 0.97, blue: 0.98))
                .cornerRadius(6)
            }
            .offset(y: -110)
           
   
        }
    }
}

#Preview {
    ProfilePage()
}
