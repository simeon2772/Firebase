//
//  Post.swift
//  SocialMediaAppFirebase
//
//  Created by Simeon Ivanov on 25.10.23.
//

import Foundation


struct Post: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var content: String
    var authorName: String
    var timestamp = Date()
    
    func contains(_ string: String) -> Bool {
        let properties = [title, content, authorName].map { $0 .lowercased() }
        let query = string.lowercased()
        let matches = properties.filter { $0.contains(query) }
        return !matches.isEmpty
    }
}


extension Post {
    static let testPost = Post(title: "Going to the gym", content: "Going to the gym is really good for you. As some people like to joke around about people who go too much and call them gym rats, then get the fuck up your cough and you become one you fucker!", authorName: "ME MYSELF AND I")
}
