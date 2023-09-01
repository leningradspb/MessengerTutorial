//
//  InboxView.swift
//  MessengerTutorial
//
//  Created by Eduard Kanevskii on 29.08.2023.
//

import SwiftUI

struct InboxView: View {
    @State private var showNewMessageView = false
    @StateObject private var viewModel = InboxViewModel()
    @State private var selectedUser: User?
    @State private var showChat = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ActiveNowView()
                
                List {
                    ForEach(0...20, id: \.self) { message in
                        InboxRowView()
                    }
                }
                .listStyle(.plain)
                .frame(height: UIScreen.main.bounds.height - 120)
            } // ScrollView
            .fullScreenCover(isPresented: $showNewMessageView, content: {
                NewMessageView(selectedUser: $selectedUser)
            })
            .navigationDestination(isPresented: $showChat, destination: {
                if let selectedUser {
                    ChatView(user: selectedUser)
                }
            })
            .onChange(of: selectedUser, perform: { newValue in
                showChat = newValue != nil
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        NavigationLink(value: viewModel.currentUser) {
                            CircularProfileImageView(user: viewModel.currentUser, size: .xsmall)
                        }
                        .navigationDestination(for: User.self) { user in
                            ProfileView(user: user)
                        }
                        
                        Text("Chats")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
//                        AuthService.shared.signOut()
                        showNewMessageView.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }

                }
            } // scrollview toolbar
            
            
        } // NavigationStack
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}
