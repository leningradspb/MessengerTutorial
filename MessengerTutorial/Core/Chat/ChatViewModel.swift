//
//  ChatViewModel.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 01.09.2023.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    @Published var messages: [Message] = []
    let toUser: User
    
    init(toUser: User) {
        self.toUser = toUser
        observeMessage()
    }
    
//    @MainActor
    func observeMessage() {
        MessageService.observeMessages(chatPartner: toUser) { [weak self] messages in
            guard let self = self else { return }
            self.messages.append(contentsOf: messages)
        }
    }
    
    func sendMessage() {
        MessageService.sendMessage(messageText, toUser: toUser)
    }
}
