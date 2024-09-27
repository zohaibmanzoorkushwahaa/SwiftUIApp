//
//  SignInGoogleHelper.swift
//  SwiftUIApp
//
//  Created by Muhammad Irfan Zafar on 25/09/2024.
//

import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignResultModel {
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
    
}

final class SignInGoogleHelper {
    
    @MainActor
    func signIn() async throws -> GoogleSignResultModel? {
      
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }

         let _ = GIDConfiguration.init(clientID: "184030261807-5d2v7kddcloa2l6g7ljfc9889q6p29pm.apps.googleusercontent.com")

        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        let user = result.user
        guard let idToken = user.idToken?.tokenString else {
            throw URLError(.unknown)
        }
        
        let tokens = GoogleSignResultModel(
            idToken: idToken,
            accessToken: user.accessToken.tokenString,
            name: user.profile?.name,
            email: user.profile?.email
        )
        
        return tokens
    }
    
}
