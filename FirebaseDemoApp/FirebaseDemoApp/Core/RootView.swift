//
//  RootView.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 1.08.24.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false
    var body: some View {
        ZStack {
            if !showSignInView {
                TabBarView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let authUser = try? AuthManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack {
                AuthView(showSignInView: $showSignInView)
            }
        })
    }
}

#Preview {
    RootView()
}
