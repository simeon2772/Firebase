//
//  SignInGoogleHelper.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 2.08.24.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
//    let name: String?
//    let email: String?
}

final class SignInGoogleHelper {
    
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.badURL)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badURL)
        }
        let accessToken = gidSignInResult.user.accessToken.tokenString
//        let name = gidSignInResult.user.profile?.name
//        let email = gidSignInResult.user.profile?.email
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        return tokens
    }
}
