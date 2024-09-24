//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Muhammad Irfan Zafar on 23/09/2024.
//

import SwiftUI

protocol LoginViewModel: BaseViewModel {
    var email: String  { get set }
    var password: String { get set }
    func signIn()
}

class LoginViewModelImpl: BaseViewModelImpl, LoginViewModel {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signIn() {
        guard !email.isEmpty,
              !password.isEmpty else {
            print("No email and password found")
            return
        }
        
        Task {
            do {
                let result: () = try await AuthManager.shared.loginUser()
                print("Success")
                print(result)
            } catch {
                print("Error: \(error)")
            }
            
        }
    }
}

struct LoginInView<ViewModel: LoginViewModel>: View {
    
    @StateObject var vm: ViewModel
    
    var body: some View {
        ZStack {
            Image("background", bundle: .main)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            
            ScrollView {
                VStack {
                    Text("SwiftUI Fantasy")
                        .foregroundColor(.white)
                        .font(.largeTitle.italic())
                        .bold()
                        .padding(.top, 50)
                    
                    Spacer(minLength: 100)
                    
                    VStack(spacing: 20) {  // Add spacing between text fields
                        TextField("Email", text: $vm.email)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                        
                        
                        SecureField("Password", text: $vm.password)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                        
                        
                        Spacer(minLength: 20)
                        
                        Button(action: {
                            // Add button action here
                        }, label: {
                            Text("Sign In")
                                .foregroundColor(.white)
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black.opacity(0.8))
                                .cornerRadius(10)
                        })
                        
                        
                        
                        
                        
                        
                    }
                    .padding(.horizontal, 15)
                    
                }
            }
        }
    
        
    }
}

#Preview {
    LoginInView(vm: LoginViewModelImpl(router: ScreenFactory.Router()))
}
