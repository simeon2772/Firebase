//
//  Message.swift
//  ChatAppDemoFirebase
//
//  Created by Simeon Ivanov on 31.10.23.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}


extension Message {
    static let messageSample = Message(id: "12345", text: "Hello there, how are you doing? I need to make this message longer for testing purposes", received: false, timestamp: Date())
}
