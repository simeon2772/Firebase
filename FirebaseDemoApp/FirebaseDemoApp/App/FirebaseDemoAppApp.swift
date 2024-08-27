//
//  FirebaseDemoAppApp.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 1.08.24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct FirebaseDemoAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        FirebaseApp.configure()
        print("Configured Firebase app")
    }
    
    var body: some Scene {
        WindowGroup {
//            RootView()
//            CrashCrashView()
            PerformanceView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {

    }
}
