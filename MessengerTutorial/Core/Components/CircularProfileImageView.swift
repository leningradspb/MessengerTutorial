//
//  CircularProfileImageView.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 30.08.2023.
//

import SwiftUI

struct CircularProfileImageView: View {
    var user: User?
    let size: ProfileImageSize
    
    var body: some View {
        if let imageURL = user?.profileImageURL {
            Image(imageURL)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .foregroundColor(.gray)
        }
    }
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(user: User.mock_user, size: .medium)
    }
}


enum ProfileImageSize {
    case xxsmall
    case xsmall
    case small
    case medium
    case large
    case xlarge
    
    var dimension: CGFloat {
        switch self {
            
        case .xxsmall:
            return 28
        case .xsmall:
            return 32
        case .small:
            return 40
        case .medium:
            return 56
        case .large:
            return 64
        case .xlarge:
            return 80
        }
    }
}
