//
//  LoginViewModel.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 31.08.2023.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func login() async throws {
        try await AuthService.shared.login(with: email, password: password)
    }
}
