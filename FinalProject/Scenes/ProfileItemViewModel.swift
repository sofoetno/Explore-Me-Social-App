//
//  ProfileItemViewModel.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 30.01.24.
//

import Foundation

@MainActor
final class ProfileItemViewModel: ObservableObject {
    @Published var userId: String = ""
    @Published var currentProfileImageUrl: String = ""
    @Published var fullName: String = ""
    
    func getUser() async throws {
        let user = try await UserManager.shared.getUser(by: userId)
        currentProfileImageUrl = user?.imageUrl ?? ""
        fullName = user?.fullName ?? ""
    }
}
