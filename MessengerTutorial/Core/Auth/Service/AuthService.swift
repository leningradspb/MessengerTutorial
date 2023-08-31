//
//  AuthService.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 31.08.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG: \(userSession?.uid)")
    }
    
    @MainActor
    func login(with email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            print("Debug: log in user \(result.user.uid)")
        } catch {
            print("DEBUG: ERROR! login catch block \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(with email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print("Debug: crated user \(result.user.uid)")
            try await self.uploadUserData(email: email, fullName: fullName, id: result.user.uid)
        } catch {
            print("DEBUG: ERROR! createUser catch block \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print("Failed signOut")
        }
    }
    
    private func uploadUserData(email: String, fullName: String, id: String) async throws {
        let user = User(id: id, fullName: fullName, email: email)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
    }
}
