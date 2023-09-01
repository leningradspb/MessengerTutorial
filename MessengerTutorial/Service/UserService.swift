//
//  UserService.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 31.08.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserService {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init() {
//        Task { try await fetchCurrentUser() }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let id = Auth.auth().currentUser?.uid else {return}
        let snapshot = try await Firestore.firestore().collection("users").document(id).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
        print("DEBUG: current user is \(user.id)")
    }
    
    @MainActor
    func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let users = snapshot.documents.compactMap { try? $0.data(as: User.self) }
        return users
    }
}
