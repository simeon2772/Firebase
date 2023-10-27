//
//  PostListView.swift
//  SocialMediaAppFirebase
//
//  Created by Simeon Ivanov on 25.10.23.
//

import SwiftUI

struct PostListView: View {
    //    private var posts = [Post.testPost]
    @State private var postsViewModel = PostsViewModel()
    @State private var searchText = ""
    @State private var showNewPostForm = false
    
    var body: some View {
        NavigationStack {
            List(postsViewModel.posts) { post in
                if searchText.isEmpty || post.contains(searchText) {
                    PostRowView(post: post, deleteAction: postsViewModel.makeDeleteAction(for: post))
                }
            }
            .animation(.default, value: postsViewModel.posts)
            .searchable(text: $searchText)
            .navigationTitle("Posts")
            .toolbar {
                Button {
                    showNewPostForm = true
                } label: {
                    Label("New Post", systemImage: "square.and.pencil")
                }
            }
        }
        .onAppear(perform: {
            postsViewModel.fetchPosts()
        })
        .sheet(isPresented: $showNewPostForm) {
            NewPostFormView(createAction: postsViewModel.makeCreateAction())
        }
    }
}

#Preview {
    PostListView()
}
