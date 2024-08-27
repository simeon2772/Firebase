//
//  AuthView.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 1.08.24.
//

import SwiftUI
import Observation
import GoogleSignIn
import GoogleSignInSwift

@MainActor
@Observable
final class GoogleSignInAuthViewModel {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        
        let tokens = try await helper.signIn()
        
        let authDataResult = try await AuthManager.shared.signInWithGoogle(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    func signInAnonymous() async throws {
        let authDataResult = try await AuthManager.shared.signInAnonymous()
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
}

@MainActor
struct AuthView: View {
    @State private var googleViewModel = GoogleSignInAuthViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            
            Button {
                Task {
                    do {
                        try await googleViewModel.signInAnonymous()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Sign In Anonymously")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.orange ,in: .rect(cornerRadius: 10))
            }
            
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In with Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.blue ,in: .rect(cornerRadius: 10))
            }
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task {
                    do {
                        try await googleViewModel.signInGoogle()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            }
            
            Spacer()

        }
        .padding()
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        AuthView(showSignInView: .constant(false))
    }
}
