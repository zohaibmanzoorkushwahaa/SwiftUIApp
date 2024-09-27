//
//  SettingsView.swift
//  SwiftUIApp
//
//  Created by Muhammad Irfan Zafar on 24/09/2024.
//

import SwiftUI

protocol SettingsViewModel: BaseViewModel {
    var authProviders: [AuthProviderOption] { get set }
    
    func logout()
    
    func resetPassword() async throws -> Bool
    func loadAuthProviders()
}

class SettingViewModelImpl: BaseViewModelImpl, SettingsViewModel {
    
    @Published var authProviders: [AuthProviderOption] = []
    
    init(with router: ScreenFactory.Router) {
        super.init(router: router)
    }
    
    func loadAuthProviders() {

        authProviders = AuthManager.shared.getProvider()
    }
    
    func logout() {
        do {
            try AuthManager.shared.logoutUser()
            router.clearRoutes()
            router.push(.welcomeScreen)
        } catch {
            print("unable to signout user.")
        }
    }
    
    func resetPassword() async throws -> Bool {
        
        let authUser = AuthManager.shared.getAuthenticatedUser()
        guard let email = authUser.1?.email else {
            debugPrint("unable to find Email")
            return false
        }
        try await AuthManager.shared.resetPassword(email: email)
        
        return true
    }
    
    func updatePassword(pass: String) async throws {
        
        try await AuthManager.shared.updatePassword(password: pass)
    }
    
    
}

struct SettingsView<ViewModel: SettingsViewModel>: View {
    
    @StateObject var vm: ViewModel
    @State private var showAlert = false // State to manage alert visibility
    @State private var alertMessage = "Reset password link has been sent to your email." // State to manage alert message
    
    var body: some View {
        List {
            if vm.authProviders.contains(.email) {
                Section {
                    Button("Reset Password") {
                        Task {
                            do {
                                let result = try await vm.resetPassword()
                                
                                if result {
                                    // If the reset is successful, show an alert
                                    alertMessage = "Reset password link has been sent to your email."
                                    showAlert = true
                                }
                            } catch {
                                // Handle errors and show an alert if necessary
                                alertMessage = "Failed to send reset password link."
                                showAlert = true
                            }
                        }
                    }
                    
                    Button("Update Password") {
                        //TODO: GO TO Update PassScreen
                    }
                    
                    Button("Update Email") {
                        //TODO: GO TO Update Email
                    }
                } header: {
                    Text("Email Functions")
                }
            }
            
            Section {
                Button("Logout") {
                    vm.logout()
                }
                .foregroundColor(.red)
            }
            
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Reset Password"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationTitle("Settings")
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: backButton)
        .onAppear {
            vm.loadAuthProviders()
        }
    }
}

extension SettingsView {
    
    var backButton: some View {
        Button("Back", systemImage: "arrow.backward") {
            vm.router.pop()
        }
        .foregroundColor(.black)
    }
}

#Preview {
    SettingsView(vm: SettingViewModelImpl(with: ScreenFactory.Router()))
}
