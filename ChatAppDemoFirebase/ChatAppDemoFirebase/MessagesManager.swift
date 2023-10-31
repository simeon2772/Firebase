//
//  MessagesManager.swift
//  ChatAppDemoFirebase
//
//  Created by Simeon Ivanov on 31.10.23.
//

import Foundation
import Observation
import FirebaseFirestore
import FirebaseFirestoreSwift


@Observable
class MessagesManager {
    private(set) var messages: [Message] = []
    let db = Firestore.firestore()
    
    init() {
        getMessages()
    }
    
    func getMessages() {
        db.collection("messages").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            self.messages = documents.compactMap { document -> Message? in
                do {
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding messages \(error)")
                    return nil
                }
            }
            
            self.messages.sort { $0.timestamp < $1.timestamp}
        }
    }
    
    func sendMessage(text: String) {
        do {
            let newMessage = Message(id: UUID().uuidString, text: text, received: false, timestamp: Date())
            
            try db.collection("messages").document().setData(from: newMessage)
        } catch {
            print("Error sending message \(error)")
        }
    }
}
