//
//  SettingsViewModel.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 2.08.24.
//

import Observation

@MainActor
@Observable final class SettingsViewModel {
    
    var authProviders: [AuthProviderOption] = []
    
    func loadAuthProviders() {
        if let providers = try? AuthManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func deleteAccount() async throws {
        try await AuthManager.shared.delete()
    }
    
    func signOut() throws {
        try AuthManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else { return }
        
        try await AuthManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "hello123@gmail.com"
        try await AuthManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
        let password = "12344321"
        try await AuthManager.shared.updatePassword(password: password)
    }
}
