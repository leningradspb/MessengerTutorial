//
//  MessageService.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 01.09.2023.
//

import Foundation
import Firebase

struct MessageService {
    private static let messagesCollection = Firestore.firestore().collection("messages")
    
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
    
    static func observeMessages(chatPartner: User, completion: @escaping ([Message])->()) {
        guard let currentUserID = UserService.shared.currentUser?.id else { return }
        let chatPartnerID = chatPartner.id
        let query = messagesCollection.document(currentUserID).collection(chatPartnerID).order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges.filter ({ $0.type == .added }) else { return }
            var messages = changes.compactMap { try? $0.document.data(as: Message.self) }
            
            for (index, message) in messages.enumerated() where message.fromID != currentUserID {
                messages[index].user = chatPartner
            }
            
            completion(messages)
        }
        
    }
}
