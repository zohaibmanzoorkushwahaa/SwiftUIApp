//
//  SwiftUIAppApp.swift
//  SwiftUIApp
//
//  Created by Muhammad Irfan Zafar on 23/09/2024.
//

import SwiftUI

@main
struct SwiftUIAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
        }
    }
}


struct MainScreen: View {
    
    @StateObject var router = ScreenFactory.Router(
        initial: nil
    )
    @State private var isActive = false
    
    var body: some View {
        Group {
            if isActive {
                
                ScreenFactory.Host(router) { route in
                    route.buildScreen(
                        router: router
                    )
                }
                
            }else {
                SplashScreen(isActive: $isActive)
            }
        }.onAppear {
            checkUser()
        }
    }
}

extension MainScreen {
    func checkUser() {
        let authUser = AuthManager.shared.getAuthenticatedUser()
        if authUser.0 {
            // If user is authenticated, route to the home screen
            router.push(.homeScreen)
        } else {
            // Optionally, if user is not authenticated, you can ensure the welcome screen is shown.
            router.push(.welcomeScreen)
        }
    }
}
