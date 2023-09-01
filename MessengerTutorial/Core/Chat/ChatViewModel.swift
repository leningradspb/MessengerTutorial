//
//  ChatViewModel.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 01.09.2023.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    let toUser: User
    
    init(toUser: User) {
        self.toUser = toUser
    }
    
    func sendMessage() {
        MessageService.sendMessage(messageText, toUser: toUser)
    }
}
