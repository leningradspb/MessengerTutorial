//
//  User.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 30.08.2023.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    var id = NSUUID().uuidString
    let fullName: String
    let email: String
    var profileImageURL: String?
}

extension User {
    static let mock_user = User(fullName: "Bruce Wayne", email: "batman@mail.ru", profileImageURL: "url")
}
