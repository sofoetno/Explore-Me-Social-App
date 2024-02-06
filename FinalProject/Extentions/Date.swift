//
//  Date.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 07.02.24.
//

import Foundation

extension Date {
    // MARK: - Methods
    func timeAgo() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        return String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current)
    }
}
