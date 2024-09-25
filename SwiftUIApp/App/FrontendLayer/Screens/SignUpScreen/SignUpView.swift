//
//  SignUpView.swift
//  SwiftUIApp
//
//  Created by Muhammad Irfan Zafar on 24/09/2024.
//

import SwiftUI

protocol SignUpViewModel: BaseViewModel {
    var email: String  { get set }
    var password: String { get set }
    var name: String { get set }
    var phoneNo: String { get set }
    
    func signUp()
}

class SignUpViewModelImpl: BaseViewModelImpl, SignUpViewModel {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var phoneNo: String = ""
    
    init(
        with router: ScreenFactory.Router
    ) {
        super.init(router: router)
    }
    
    func signUp() {
        guard !email.isEmpty,
              !password.isEmpty,
              !name.isEmpty,
              !phoneNo.isEmpty 
        else {
            print("No email and password found")
            return
        }
        
        Task {
            do {
                let result = try await AuthManager.shared.createUser(
                    email: email,
                    pasword: password,
                    phonoNo: phoneNo,
                    name: name
                )
                
                print("Success")
                router.push(.homeScreen)
                print(result)
            } catch {
                print("Error: \(error)")
            }
            
        }
    }
}

struct SignUpView<ViewModel: SignUpViewModel>: View {
    
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
                        TextField("", text: $vm.name)
                            .placeholder(when: vm.name.isEmpty) {
                                Text("Name").foregroundColor(.white)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                        
                        TextField("", text: $vm.phoneNo)
                            .placeholder(when: vm.phoneNo.isEmpty) {
                                Text("Phone No").foregroundColor(.white)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                        
                        TextField("", text: $vm.email)
                            .placeholder(when: vm.email.isEmpty) {
                                Text("Email").foregroundColor(.white)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                        
                        
                        SecureField("", text: $vm.password)
                            .placeholder(when: vm.password.isEmpty) {
                                Text("Password").foregroundColor(.white)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                        
                        
                        Spacer(minLength: 20)
                        
                        
                        Button {
                            vm.signUp()
                        } label: {
                            Text("Sign Up")
                                .foregroundColor(.white)
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black.opacity(0.8))
                                .cornerRadius(10)
                        }
 
                    }
                    .padding(.horizontal, 15)
                    
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: backButton)
    
        
    }
}

extension SignUpView {
    
    var backButton: some View {
        Button("Back", systemImage: "arrow.backward") {
            vm.router.pop()
        }
        .foregroundColor(.black)
    }
}

#Preview {
    SignUpView(vm: SignUpViewModelImpl(with: ScreenFactory.Router()))
}
