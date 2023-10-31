//
//  ContentView.swift
//  ChatAppDemoFirebase
//
//  Created by Simeon Ivanov on 31.10.23.
//

import SwiftUI

struct ContentView: View {
    @State private var messagesManager = MessagesManager()

    var body: some View {
        VStack {
            VStack {
                TitleRow()
                ScrollView {
                    ForEach(messagesManager.messages, id: \.id) { message in
                        MessageBuble(message: message)
                    }
                }
                .padding(.top, 25)
                .background(.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                
            }
            .background(Color("customBlue"))
            ZStack {
                MessageField()
                    .environment(messagesManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
