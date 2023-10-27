//
//  PostsViewModel.swift
//  SocialMediaAppFirebase
//
//  Created by Simeon Ivanov on 26.10.23.
//

import Foundation
import Observation

@Observable class PostsViewModel {
    var posts: [Post] = []
    
    func makeCreateAction() -> NewPostFormView.CreateAction {
        return { [weak self] post in
            try await PostsRepository.create(post)
            self?.posts.insert(post, at: 0)
        }
    }
    
    func makeDeleteAction(for post: Post) -> PostRowView.DeleteAction {
        return { [weak self] in
            try await PostsRepository.delete(post)
            self?.posts.removeAll { $0.id == post.id }
        }
    }
    
    func fetchPosts() {
        Task {
            do {
                self.posts = try await PostsRepository.fetchPosts()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
