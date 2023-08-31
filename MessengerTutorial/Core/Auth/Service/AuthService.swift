//
//  AuthService.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 31.08.2023.
//

import Foundation
import Firebase

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG: \(userSession?.uid)")
    }
    
     func login(with email: String, password: String) async throws {
        
    }
    
    func createUser(with email: String, password: String, fullName: String) async throws {
       do {
           let result = try await Auth.auth().createUser(withEmail: email, password: password)
           print("Debug: crated user \(result.user.uid)")
       } catch {
           print("DEBUG: ERROR! createUser catch block \(error.localizedDescription)")
       }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print("Failed signOut")
        }
    }
}
