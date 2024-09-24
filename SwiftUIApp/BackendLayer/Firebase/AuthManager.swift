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
    
    func loginUser() async throws {
    
        let result = try await Auth.auth().signIn(withEmail: "", password: "")
        
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
}
