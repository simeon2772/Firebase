//
//  SocialMediaAppFirebaseApp.swift
//  SocialMediaAppFirebase
//
//  Created by Simeon Ivanov on 25.10.23.
//

import SwiftUI
import Firebase

@main
struct PostsAppFirebase: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            PostListView()
        }
    }
}
