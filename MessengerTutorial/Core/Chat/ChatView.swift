//
//  ChatView.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 30.08.2023.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel
    @State var user: User
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(toUser: user))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                //header
                VStack {
                    CircularProfileImageView(user: user, size: .xlarge)
                    
                    VStack(spacing: 4) {
                        Text(user.fullName)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                //messages
                ForEach(viewModel.messages) { message in
                    ChatMessageCell(message: message)
                }
            }
            
            Spacer()
            //input
            // axis - чтобы растягивался
            ZStack(alignment: .trailing) {
                TextField("Messgage....", text: $viewModel.messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 49)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                
                Button {
                    print("send message tapped")
                    viewModel.sendMessage()
                    // TODO: check in view model after request
                    viewModel.messageText = ""
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
                
            }
            .padding()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: User.mock_user)
    }
}
