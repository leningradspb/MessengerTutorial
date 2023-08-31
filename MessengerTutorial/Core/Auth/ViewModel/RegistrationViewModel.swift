//
//  RegistrationViewModel.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 31.08.2023.
//

import SwiftUI

class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var fullName = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(with: email, password: password, fullName: fullName)
    }
}
