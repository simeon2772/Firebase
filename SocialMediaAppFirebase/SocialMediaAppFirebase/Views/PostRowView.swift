//
//  PostRowView.swift
//  SocialMediaAppFirebase
//
//  Created by Simeon Ivanov on 25.10.23.
//

import SwiftUI

struct PostRowView: View {
    typealias DeleteAction = () async throws -> Void
    let post: Post
    let deleteAction: DeleteAction
    
    @State private var showConfirmationDialog = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(post.authorName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()
                Text(post.timestamp.formatted(date: .numeric, time: .standard))
                    .font(.caption)
            }
            .foregroundColor(.gray)
            Text(post.title)
                .font(.title3)
                .fontWeight(.semibold)
            Text(post.content)
            
            HStack {
                Spacer()
                Button(role: .destructive, action: {
                    showConfirmationDialog = true
                }) {
                    Label("Delete", systemImage: "trash")
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.borderless)
            }
        }
        .padding(.vertical)
        .confirmationDialog("Are you sure you want to delete this post?", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
            Button("Delete", role: .destructive, action: deletePost)
        }
    }
    private func deletePost() {
        Task {
            do {
                try await deleteAction()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}

#Preview {
    List {
        PostRowView(post: Post.testPost, deleteAction: {})
    }
}
