//
//  SignInEmailView.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 1.08.24.
//

import SwiftUI

@MainActor
struct SignInEmailView: View {
    @State private var authViewModel = AuthViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("Email...", text: $authViewModel.email)
                .padding()
                .background(Color(.systemGray5), in: .rect(cornerRadius: 12))
            
            SecureField("Password", text: $authViewModel.password)
                .padding()
                .background(Color(.systemGray5), in: .rect(cornerRadius: 12))
            
            
            Button {
                Task {
                    do {
                        try await authViewModel.signUp()
                        showSignInView = false
                        return
                    } catch {
                        print(error)
                    }
                    
                    do {
                        try await authViewModel.signIn()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.blue ,in: .rect(cornerRadius: 10))
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In with Email")
    }
}

#Preview {
    NavigationStack {
        SignInEmailView(showSignInView: .constant(false))
    }
}
