//
//  PostItem.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct PostItem: View {
    let post: String
    
    
    var body: some View {
        
        ZStack {
            ZStack {
                Image("test2")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
    
                        Image("avatar")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .cornerRadius(6)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .shadow(color: .white, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
            
            ZStack {
                CustomRectangleForCell()
                
                VStack(spacing: 24) {
                    Text("Information:")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 280, alignment: .topLeading)
                    
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 300, height: 1)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.98, green: 0.97, blue: 0.97).opacity(0), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.98, green: 0.98, blue: 0.98), location: 0.09),
                                    Gradient.Stop(color: Color(red: 0.98, green: 0.97, blue: 0.97).opacity(0), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0, y: 1),
                                endPoint: UnitPoint(x: 1, y: 1)
                            )
                        )
                    
                    Text("Prompt writing involves crafting clear and engaging prompts, while using images to create a visual representation of the idea or concept.")
                        .font(Font.custom("Inter", size: 15))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(width: 280, height: 64, alignment: .topLeading)
                }
            }
            .offset(y: 90)
        }
        .frame(height: 324)
        .shadow(color: Color(red: 0.2, green: 0.33, blue: 0.55).opacity(0.3), radius: 22, x: 0, y: 14)
    }
}

#Preview {
    PostItem(post: "Test post")
}
