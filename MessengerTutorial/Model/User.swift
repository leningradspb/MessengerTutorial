//
//  User.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 30.08.2023.
//

import Foundation
//import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    let id: String
//    var id = NSUUID().uuidString
//    @DocumentID var uid: String?
    let fullName: String
    let email: String
    var profileImageURL: String?
    
//    var id: String {
//        uid ?? NSUUID().uuidString
//    }
}

extension User {
    static let mock_user = User(id: NSUUID().uuidString, fullName: "Bruce Wayne", email: "batman@mail.ru", profileImageURL: "messenger-app-icon")
}
