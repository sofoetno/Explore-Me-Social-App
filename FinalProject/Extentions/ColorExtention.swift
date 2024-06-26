//
//  ColorExtantion.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 15.01.24.
//

import SwiftUI

struct AppColors {
    // MARK: - Static properties
    static let primary = Color(hex: 0x2C64E3)
    static let black = Color(hex: 0x191B1F)
    static let darkGray = Color(hex: 0x7C8387)
    static let lightGray = Color(hex: 0xE1E3E7)
    static let silver = Color(hex: 0xEDEFF3)
    static let white = Color(hex: 0xF7F7F7)
    static let customRed = Color(hex: 0xE95050)
    static let customLightBlue = Color(hex: 0xC8D1FE)
}


extension Color {
    // MARK: - Inits
    init(hex: UInt32, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
