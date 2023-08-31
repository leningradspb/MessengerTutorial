//
//  AuthService.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 31.08.2023.
//

import Foundation
import Firebase

class AuthService {
    static func login(with email: String, password: String) async throws {
        
    }
    
   static func createUser(with email: String, password: String, fullName: String) async throws {
       do {
           let result = try await Auth.auth().createUser(withEmail: email, password: password)
           print("Debug: crated user \(result.user.uid)")
       } catch {
           print("DEBUG: ERROR! createUser catch block \(error.localizedDescription)")
       }
    }
}
