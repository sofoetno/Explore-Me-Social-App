//
//  PostItem.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct PostItem: View {
    let post: PostModel
    @State var isLiked: Bool = false
    
    
    var body: some View {
        
        ZStack {
            ZStack {
                AsyncImage(url: URL(string: post.photoUrl ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                    } else if (phase.error != nil) {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                    } else {
                        ProgressView()
//                        Image("test2")
//                            .resizable()
//                            .scaledToFit()
//                            .cornerRadius(10)
                    }
                }
                
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 74, height: 74)
                
                Image("avatar")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .cornerRadius(6)
                    .clipShape(Circle())
                    .shadow(color: .white, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(isLiked ? AppColors.customRed : .purple)
                        .font(.title)
                }
                .onTapGesture {
                    isLiked.toggle()
                }
                .offset(x: 120, y: -90)
                
                
                    
            }
            
            ZStack {
                CustomRectangleForCell()
                
                VStack(spacing: 8) {
                    Text("Explore the story: \(post.title)")
                        .foregroundStyle(.white)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .lineLimit(2)
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
                    
                    Text(post.description)
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
    PostItem(post: PostModel(title: "Story name", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quis risus, neque cursus risus. Eget dictumst vitae enim, felis morbi. Quis risus, neque cursus risus. Eget dictumst vitae enim, felis morbi. Quis risus, neque cursus risus."))
}
