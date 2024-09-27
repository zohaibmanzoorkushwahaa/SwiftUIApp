//
//  AuthManager.swift
//  SwiftUIApp
//
//  Created by Muhammad Irfan Zafar on 23/09/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

enum AuthState {
    
    case authenticated // Anonymously authenticated in Firebase.
    case signedIn // Authenticated in Firebase using one of service providers, and not anonymous.
    case signedOut // Not authenticated in Firebase.
}

enum AuthProviderOption: String {
    
    case email = "password"
    case googlle = "google.com"
}

struct AuthDataResultModel {
    var uid: String
    var name: String?
    var email: String?
    var phoneNo: String?
    let photoURL: String?
    
    init(user: User) {
        self.uid = user.uid
        self.name = user.displayName
        self.email = user.email
        self.phoneNo = user.phoneNumber
        self.photoURL = user.photoURL?.absoluteString
    }
}

class AuthManager: ObservableObject {

    static let shared = AuthManager()
    
    private init() {}
    
    func getAuthenticatedUser() -> (Bool, AuthDataResultModel?) {
        guard let user = Auth.auth().currentUser else {
           return (false, nil)
        }
        
        return (true, AuthDataResultModel(user: user))
    }
    
    func getProvider() -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            return []
        }
        
        var providers: [AuthProviderOption] = []
        for provider in providerData {
          
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            } else {
                assertionFailure("Provider Option not found \(provider.providerID)")
            }
        }
        
        return providers
    }
 
    
    func setUserData(id: String, name: String, email: String, phoneNo: String, photoURL: String) async throws {
           let db = Firestore.firestore()
           
           do {
               try await db.collection("users") // Replace "users" with your collection name
                   .document(id) // Use the uid of the user
                   .setData([
                       "name": name ,
                       "email": email ,
                       "phoneNo": phoneNo,
                       "photoURL": photoURL
                   ])
           } catch {
               print(error.localizedDescription)
               throw error // Re-throw the error to let the caller handle it
           }
    }
    
    
    func logoutUser() throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw(error)
        }
    }
}

//MARK: - SIGN IN EMAIL
extension AuthManager {
    func createUser(email: String, pasword: String, phonoNo: String, name: String) async throws ->  AuthDataResultModel {
        do {
           let result =  try await Auth.auth().createUser(withEmail: email, password: pasword)
            let fbUser = result.user
            let user = AuthDataResultModel(user: fbUser)
            if user.uid != "" {
                try await setUserData(id: user.uid, name: name, email: user.email ?? "", phoneNo: phonoNo, photoURL: user.photoURL ?? "")
            }
            return user
        } catch (let error) {
            print(error.localizedDescription)
            throw error
        }
      
    }
    
    @discardableResult
    func loginUser(email: String, password: String) async throws -> Bool  {
    
        do {
            let _ = try await Auth.auth().signIn(withEmail: email, password: password)
            
            return true
        } catch {
            debugPrint("unable to login, \(error.localizedDescription)")
            throw(error)
        }

    }
    
    func resetPassword(email: String) async throws {
        
       try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws {
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws {
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updateEmail(to: email)
    }
}

//MARK: - SIGN IN SSO
extension AuthManager {
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignResultModel) async throws -> AuthDataResultModel {
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: tokens.idToken,
            accessToken: tokens.accessToken
        )
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let result = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: result.user)
    }
}
