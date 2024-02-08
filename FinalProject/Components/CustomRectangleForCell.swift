//
//  CustomLineForCell.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 18.01.24.
//

import SwiftUI

struct CustomRectangleForCell: View {
    // MARK: - Body
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 330, height: 166)
                .background(
                    gradientColor
                )
                .cornerRadius(30)
        }
        
    }
    
    // MARK: - Computed properties
    var gradientColor: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.19, green: 0.23, blue: 0.36).opacity(0.20), location: 0.05),
                Gradient.Stop(color: Color(red: 0.19, green: 0.23, blue: 0.36).opacity(0.90), location: 0.26),
                Gradient.Stop(color: Color(red: 0.19, green: 0.23, blue: 0.36), location: 0.93),
            ],
            startPoint: UnitPoint(x: 0, y: -0.06),
            endPoint: UnitPoint(x: 0, y: 1.08)
        )
    }
}

// MARK: - Preview
#Preview {
    CustomRectangleForCell()
}
