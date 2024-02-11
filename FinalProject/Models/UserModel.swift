//
//  UserModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 27.01.24.
//

import Foundation

struct UserModel: Codable {
    // MARK: - Properties
    var imageUrl: String? = nil
    let userId: String
    let email: String
    let fullName: String
}
