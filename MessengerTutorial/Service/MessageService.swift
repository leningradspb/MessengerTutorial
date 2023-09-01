//
//  MessageService.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 01.09.2023.
//

import Foundation
import Firebase

struct MessageService {
    private let messagesCollection = Firestore.firestore().collection("messages")
    
    static func sendMessage(_ message: String, toUser: User) {
        guard let currentUserID = UserService.shared.currentUser?.id else { return }
        let chatPartnerID = toUser.id
        
        let currentUserRef = messagesCollection.document(currentUserID).collection(chatPartnerID).document()
        let chatPartnerRef = messagesCollection.document(chatPartnerID).collection(currentUserID)
        
        let messageID = currentUserRef.documentID
        let message = Message(id: messageID, fromID: currentUserID, toID: chatPartnerID, messageText: message, timestamp: Timestamp())
        
        guard let messageData = try? Firestore.Encoder().encode(message) else {
            print("FAILED TO ENCOD MESSAGE")
            return
        }
        
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageID).setData(messageData)
    }
}
