//
//  WelcomeView.swift
//  SwiftUIApp
//
//  Created by Muhammad Irfan Zafar on 24/09/2024.
//

import SwiftUI

@MainActor
protocol WelcomeViewModel: BaseViewModel {
    
    func signInGoogle() async throws
}

class WelcomeViewModelImpl: BaseViewModelImpl, WelcomeViewModel {
    
    init(
        with router: ScreenFactory.Router
    ) {
        super.init(router: router)
    }
    
    func signInGoogle() async throws {
         
        guard let tokens = try await SignInGoogleHelper().signIn() else {
            throw(URLError(.badURL))
        }
        
        try await AuthManager.shared.signInWithGoogle(tokens: tokens)
 
    }
}

struct WelcomeView<ViewModel: WelcomeViewModel>: View {
    
    @StateObject var vm: ViewModel
      
    var body: some View {
        ZStack {
            Image("background", bundle: .main)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("SwiftUI Fantasy")
                    .foregroundColor(.white)
                    .font(.largeTitle.italic())
                    .bold()
                    .padding(.top, 50)
                
                Spacer(minLength: 30)
                
             
                Button(action: {
                    vm.router.push(.loginScreen)
                }, label: {
                    Text("Sign In with Email")
                        .font(.title3).bold()
                        .foregroundColor(.white)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow.opacity(0.8))
                        .cornerRadius(30)
                })
                
                Button(action: {
                    vm.router.push(.signUpScreen)
                }, label: {
                    Text("Sign Up")
                        .font(.title3).bold()
                        .foregroundColor(.white)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow.opacity(0.8))
                        .cornerRadius(30)
                })
                
                Button(action: {
                    Task {
                        
                        do {
                            try await vm.signInGoogle()
                            
                            vm.router.clearRoutes()
                            vm.router.push(.homeScreen)
                        } catch {
                            debugPrint("Unable to Sign In With Google.")
                        }
                    }
                }, label: {
                    Text("Sign In with Google")
                        .font(.title3).bold()
                        .foregroundColor(.white)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow.opacity(0.8))
                        .cornerRadius(30)
                })
                .padding(.bottom,20)
                
                
            }
            .padding(.horizontal, 10)
        }
        .navigationBarHidden(true)
       
    }
}

#Preview {
    WelcomeView(vm: WelcomeViewModelImpl(with: ScreenFactory.Router())) // Correct initialization
}
