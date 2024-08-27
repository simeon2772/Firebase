//
//  ProfileView.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 13.08.24.
//

import SwiftUI
import PhotosUI

@MainActor
struct ProfileView: View {
    @State private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var url: URL? = nil
    
    let preferenceOptions: [String] = ["Sports", "Movies", "Books"]
    
    private func preferenceIsSelected(text: String) -> Bool {
        viewModel.user?.preferences?.contains(text) == true
    }
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("User ID: \(user.userId)")
                
                if let isAnonymous = user.isAnonymous {
                    Text("Is Anonymous: \(isAnonymous.description.capitalized)")
                }
                
                Button {
                    Task {
                        try await viewModel.togglePremiumStatus()
                    }
                } label: {
                    Text("User is premium: \((user.isPremium ?? false).description.capitalized)")
                }
                
                VStack {
                    HStack {
                        ForEach(preferenceOptions, id: \.self) { option in
                            Button(option) {
                                if preferenceIsSelected(text: option) {
                                    viewModel.removeUserPreference(text: option)
                                } else {
                                    viewModel.addUserPreference(text: option)
                                }
                            }
                            .tint(preferenceIsSelected(text: option) ? .red : .green)
                        }
                    }
                    .font(.headline)
                    .buttonStyle(.borderedProminent)
                    
                    Text("User preferences: \((user.preferences ?? []).joined(separator: ", "))")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                 
                Button {
                    viewModel.addFavoutireMovie()
                } label: {
                    Text("Add Favourite Movie")
                }
                
                Button(role: .destructive) {
                    viewModel.removeFavoutireMovie()
                } label: {
                    Text("Remove Favourite Movie")
                }
                
                Text("Favourite Movie: \(user.favouriteMovie?.title ?? "")")
                
                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                    Text("Select a photo")
                }
                
                if let urlString = viewModel.user?.profileImageURL, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(.rect(cornerRadius: 10))
                    } placeholder: {
                        ProgressView()
                            .frame(width: 150, height: 150)
                    }
                }
                
                if viewModel.user?.profileImagePath != nil {
                    Button("Delete Profile Image") {
                        viewModel.deleteProfileImage()
                        print("Deleted")
                    }
                }
                
            }
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
        .onChange(of: selectedItem, { _, newValue in
            if let newValue {
                viewModel.saveProfileImage(item: newValue)
            }
        })
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }

            }
        }
    }
}

#Preview {
    NavigationStack {
//        ProfileView(showSignInView: .constant(false))
        RootView()
            .navigationTitle("Products")
    }
}
