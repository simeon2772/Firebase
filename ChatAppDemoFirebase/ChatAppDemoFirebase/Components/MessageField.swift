//
//  MessageField.swift
//  ChatAppDemoFirebase
//
//  Created by Simeon Ivanov on 31.10.23.
//

import SwiftUI

struct MessageField: View {
    @Environment(MessagesManager.self) private var messagesManager
    @State private var message = ""
    
    var body: some View {
        HStack {
            CustomTextField(placeholder: Text("Enter your message here"), text: $message)
            
            Button {
                messagesManager.sendMessage(text: message)
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(Color.customlightBlue)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 17)
        .background(Color.customGray)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
        .padding()
    }
}

#Preview {
    MessageField()
        .environment(MessagesManager())
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChange: (Bool) -> () = { _ in }
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder.opacity(0.5)
            }
            
            TextField("", text: $text, onEditingChanged: editingChange, onCommit: commit)
        }
    }
}
