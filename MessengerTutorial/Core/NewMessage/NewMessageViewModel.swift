//
//  NewMessageViewModel.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 01.09.2023.
//

import Foundation

@MainActor
class NewMessageViewModel: ObservableObject {
    @Published var users: [User] = []
    
    init() {
        Task { try await fetchUsersExceptCurrentUser() }
    }
    
    @MainActor
    private func fetchUsersExceptCurrentUser() async throws {
        guard let currentUserID = UserService.shared.currentUser?.id else { return }
        users = try await UserService.shared.fetchAllUsers().filter { $0.id != currentUserID }
    }
}
