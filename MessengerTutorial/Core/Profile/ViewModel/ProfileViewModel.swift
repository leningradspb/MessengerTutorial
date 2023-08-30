//
//  ProfileViewModel.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 30.08.2023.
//

import Foundation
import SwiftUI
import PhotosUI

class ProfileViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task {
                try await loadImage()
            }
        }
    }
    
    @Published var profileImage: Image?
    
    func loadImage() async throws {
        guard let item = selectedItem, let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        profileImage = Image(uiImage: uiImage)
    }
}
