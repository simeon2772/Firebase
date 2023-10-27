//
//  PostsRepository.swift
//  SocialMediaAppFirebase
//
//  Created by Simeon Ivanov on 26.10.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct PostsRepository {
    static let postsReference = Firestore.firestore().collection("posts")
    
    static func create(_ post: Post) async throws {
        let document = postsReference.document(post.id.uuidString)
        try await document.setData(from: post)
    }
    
    static func fetchPosts() async throws -> [Post] {
        let snapshot = try await postsReference.order(by: "timestamp", descending: true).getDocuments()
        return snapshot.documents.compactMap { document in
            try! document.data(as: Post.self)
        }
    }
    
    static func delete(_ post: Post) async throws {
        let document = postsReference.document(post.id.uuidString)
        try await document.delete()
    }
}

private extension DocumentReference {
    func setData<T: Encodable>(from value: T) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            try! setData(from: value) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume()
            }
        }
    }
}
