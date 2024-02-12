//
//  OnboardingView.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 08.02.24.
//

import SwiftUI

struct OnboardingView: View, WithRootNavigationController {
    // MARK: - Body
    var body: some View {
        ZStack {
            onboardingBackground
            
            logo
            
            retanglesWithPhotos
            
            VStack(spacing: 30) {
                appTextLabel
                
                HStack {
                    getStartedButton
                }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 14)
                    .background(Color(red: 0.82, green: 0.82, blue: 0.82).opacity(0.3))
                    .cornerRadius(30)
            }
            .offset(y: 280)
        }
        

    }
    
    // MARK: - Computed properties
    var onboardingRectangle: some View {
        Rectangle()
        .foregroundColor(.clear)
        .frame(width: 120, height: 120)
        .background(
        LinearGradient(
        stops: [
        Gradient.Stop(color: Color(red: 0.32, green: 0.32, blue: 0.78), location: 0.00),
        Gradient.Stop(color: Color(red: 0.32, green: 0.32, blue: 0.78).opacity(0), location: 1.00),
        ],
        startPoint: UnitPoint(x: 1.03, y: -0.02),
        endPoint: UnitPoint(x: 0, y: 1)
        )
        )
        .cornerRadius(8)
        .rotationEffect(Angle(degrees: 45))
        
    }
    
    var onboardingRectangleBack: some View {
        Rectangle()
        .foregroundColor(.clear)
        .frame(width: 120, height: 120)
        .background(
        LinearGradient(
        stops: [
        Gradient.Stop(color: Color(red: 0.32, green: 0.32, blue: 0.78).opacity(0), location: 0.00),
        Gradient.Stop(color: Color(red: 0.32, green: 0.32, blue: 0.78), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
        )
        )
        .cornerRadius(8)
        .rotationEffect(Angle(degrees: 45))
    }
    
    // MARK: - Computed properties
    var onboardingBackground: some View {
        Image("onboardingBackground")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var logo: some View {
        Image("mainLogo2")
            .resizable()
            .scaledToFit()
            .padding(50)
            .offset(y: -290)
    }
    
    var retanglesWithPhotos: some View {
        ZStack() {
            VStack(spacing: 100) {
                onboardingRectangle
                    .overlay {
                        Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 120, height: 120)
                        .background(
                        Image("cook")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipped()
                        )
                        .cornerRadius(12)
                        .rotationEffect(Angle(degrees: 45))
                        .offset(y: 12)
                    }
                
                onboardingRectangle
                    .overlay {
                        Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 120, height: 120)
                        .background(
                        Image("music")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipped()
                        )
                        .cornerRadius(12)
                        .rotationEffect(Angle(degrees: 45))
                        .offset(y: -12)
                    }
            }
            
            HStack(spacing: 90) {
                onboardingRectangleBack
                    .overlay {
                        Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 120, height: 120)
                        .background(
                        Image("paint")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipped()
                        )
                        .cornerRadius(12)
                        .rotationEffect(Angle(degrees: 45))
                        .offset(x: 12)
                    }
                
                onboardingRectangle
                    .overlay {
                        Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 120, height: 120)
                        .background(
                        Image("photography")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipped()
                        )
                        .cornerRadius(12)
                        .rotationEffect(Angle(degrees: 45))
                        .offset(x: -12)
                    }
            }
        }
    }
    
    var appTextLabel: some View {
        VStack(spacing: 10) {
            Text("SHARE - INSPIRE - CONNECT")
            Text("Your Storytelling App")
        }
            .foregroundStyle(.white)
            .font(Font.custom("Circular Std", size: 18))
    }
    
    // MARK: - Buttons
    var getStartedButton: some View {
        Button {
            UserDefaults.standard.set(true, forKey: "has-seen-onboarding")
            
            authNavigationController?.setViewControllers([UIHostingController(rootView: LoginView())], animated: true)
            
            
        } label: {
            Text("GET STARTED")
                .foregroundStyle(.white)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
    }
}

// MARK: - Preview
#Preview {
    OnboardingView()
}
