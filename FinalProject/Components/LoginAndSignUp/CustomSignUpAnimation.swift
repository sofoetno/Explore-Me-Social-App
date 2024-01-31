//
//  CustomSignUpAnimation.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 17.01.24.
//

import SwiftUI

struct CustomSignUpAnimation: View, WithRootNavigationController {
    @State private var scale: CGFloat = 1
    
    var body: some View {
        ZStack {
            CustomBackgroundLabelForUser()

            VStack(spacing: 24) {
                Image(systemName: "hands.and.sparkles.fill")
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(red: 0.53, green: 0.55, blue: 0.96))
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 1).repeatCount(3, autoreverses: true), value: scale)
                    .onAppear {
                        scale = 3
                    }
                
                Text("Congrats!")
                    .foregroundColor(Color(red: 0.53, green: 0.55, blue: 0.96))
                    .font(.title)
                    .fontWeight(.bold)
                
                
                Text("Registration Successful! you can now log in.")
                    .foregroundStyle(AppColors.darkGray)
                
                Button {
                    goToLogin()
                } label: {
                    Text("Begin")
                }
                .primaryButtonStyle
                .padding()

            }
            .offset(y: 100)
        }
        
     

    }
    
    func goToLogin() {
        authNavigationController?.pushViewController(UIHostingController(rootView: LoginView()), animated: true)
    }
}

#Preview {
    CustomSignUpAnimation()
}
