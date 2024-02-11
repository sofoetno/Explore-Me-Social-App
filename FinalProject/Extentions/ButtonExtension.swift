//
//  ButtonExtension.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 15.01.24.
//

import SwiftUI

extension Button {
    // MARK: - Computed properties
    var primaryButtonStyle: some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.53, green: 0.55, blue: 0.96), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.32, green: 0.32, blue: 0.78), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 1, y: 1),
                    endPoint: UnitPoint(x: 0, y: 0)
                )
            )
            .cornerRadius(30)
    }
    
    
}
