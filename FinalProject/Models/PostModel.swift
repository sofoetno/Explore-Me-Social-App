//
//  PostModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 21.01.24.
//

import Foundation

struct PostModel: Codable, Identifiable {
    // MARK: - Properties
    var id: String = UUID().uuidString
    let title: String
    let description: String
    var photoUrl: String? = nil
    let userId: String
}
