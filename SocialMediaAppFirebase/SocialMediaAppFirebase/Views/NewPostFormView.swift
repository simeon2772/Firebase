//
//  NewPostFormView.swift
//  SocialMediaAppFirebase
//
//  Created by Simeon Ivanov on 25.10.23.
//

import SwiftUI

enum FormState {
    case idle, working, error
}

struct NewPostFormView: View {
    typealias CreateAction = (Post) async throws -> Void
    
    let createAction: CreateAction
    
    @Environment(\.dismiss) private var dismiss
    @State private var post = Post(title: "", content: "", authorName: "")
    @State private var state = FormState.idle
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $post.title)
                    TextField("Author Name", text: $post.authorName)
                }
                
                Section("Content") {
                    TextEditor(text: $post.content)
                        .multilineTextAlignment(.leading)
                }
                
                Button(action: createPost) {
                    if state == .working {
                        ProgressView()
                    } else {
                        Text("Create Post")
                    }
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .padding()
                .listRowBackground(Color.accentColor)
            }
            .onSubmit(createPost)
            .navigationTitle("New Post")
        }
        .disabled(state == .working)
    }
    
    private func createPost() {
        print("[NewPostForm] Creating new post...")
        Task {
            state = .working
            do {
                try await createAction(post)
                dismiss()
            } catch {
                print("[NewPostFormView] Cannot create post due to \(error.localizedDescription)")
                state = .error
            }
        }
    }
}

#Preview {
    NewPostFormView(createAction: { _ in })
}
