//
//  InboxRowView.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 29.08.2023.
//

import SwiftUI

struct InboxRowView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CircularProfileImageView(user: User.mock_user, size: .medium)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Heat Ledger")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text("Some test message a lot of text a lot of text asf a  fa coo coo")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
//                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            HStack {
                Text("Yesterday")
                
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
//        .padding(.horizontal)
        .frame(height: 72)
    }
}

struct InboxRowView_Previews: PreviewProvider {
    static var previews: some View {
        InboxRowView()
    }
}
