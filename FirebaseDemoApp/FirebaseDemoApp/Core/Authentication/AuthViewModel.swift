//
//  AuthViewModel.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 1.08.24.
//

import Foundation

@MainActor
@Observable final class AuthViewModel {
    var email = ""
    var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password")
            return
        }
        
        let authDataResult = try await AuthManager.shared.createUser(email: email, password: password)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password")
            return
        }
        
        try await AuthManager.shared.signInUser(email: email, password: password)
    }
    
    
}
