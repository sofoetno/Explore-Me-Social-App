//
//  CommentModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 22.01.24.
//

import Foundation

struct CommentModel: Codable {
    // MARK: - Properties
    var id: String = UUID().uuidString
    let userId: String
    let text: String
    let dateCreated: Date
    let postId: String
}
