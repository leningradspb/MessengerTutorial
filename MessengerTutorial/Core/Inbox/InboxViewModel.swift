//
//  InboxViewModel.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 01.09.2023.
//

import Foundation
import Combine

class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)

    }
}
