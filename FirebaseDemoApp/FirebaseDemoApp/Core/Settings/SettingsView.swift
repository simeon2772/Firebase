//
//  SettingsView.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 2.08.24.
//

import SwiftUI

@MainActor
struct SettingsView: View {
    @State private var settingsVM = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try settingsVM.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button(role: .destructive) {
                Task {
                    do {
                        try await settingsVM.deleteAccount()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Delete Account")
            }

            
            if settingsVM.authProviders.contains(.email) {
                emailSection
            } 
        }
        .onAppear {
            settingsVM.loadAuthProviders()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(true))
    }
}

extension SettingsView {
    private var emailSection: some View {
        Section {
            Button("Reset Password") {
                Task {
                    do {
                        try await settingsVM.resetPassword()
                        print("Password Reset")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Update Password") {
                Task {
                    do {
                        try await settingsVM.updatePassword()
                        print("Password Updated")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Update Email") {
                Task {
                    do {
                        try await settingsVM.updateEmail()
                        print("Email Updated")
                    } catch {
                        print(error)
                    }
                }
            }
        } header: {
            Text("Email Functions")
        }
    }
}
