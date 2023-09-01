//
//  Message.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 01.09.2023.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Message: Codable, Identifiable, Hashable {
    let id: String
    let fromID: String
    let toID: String
    let messageText: String
    let timestamp: Timestamp
    
    var user: User?
    
    var chatPartnerID: String {
        fromID == UserService.shared.currentUser?.id ? toID : fromID
    }
    
    var isFromCurrentUser: Bool {
        fromID == UserService.shared.currentUser?.id
    }
}
