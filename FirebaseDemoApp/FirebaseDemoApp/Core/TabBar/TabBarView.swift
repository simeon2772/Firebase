//
//  TabBarView.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 14.08.24.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        TabView {
            NavigationStack {
                ProductsView()
            }
            .tabItem { Label("Products", systemImage: "cart") }
            
            NavigationStack {
                FavoritesView()
            }
            .tabItem { Label("Favourites", systemImage: "star") }
            
            NavigationStack {
                ProfileView(showSignInView: $showSignInView)
            }
            .tabItem { Label("Settings", systemImage: "person") }
        }
    }
}

#Preview {
    TabBarView(showSignInView: .constant(false))
}
