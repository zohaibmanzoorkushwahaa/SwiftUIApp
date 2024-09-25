//
//  ScreenFactory.swift
//  SwiftUIApp
//
//  Created by Muhammad Irfan Zafar on 23/09/2024.
//

import Foundation
import SwiftUI

enum ScreenFactory: Equatable {
    
    typealias Host = UIPilotHost
    typealias Router = UIPilot<ScreenFactory>
    
    case welcomeScreen
    case signUpScreen
    case loginScreen
    case homeScreen
    case settingScreen
}


extension ScreenFactory {
    
    @MainActor
    @ViewBuilder
    func buildScreen(
        router: Router
    ) -> some View {
        switch self {
        
        case .welcomeScreen:
            let welcomeViewModel = WelcomeViewModelImpl(
                with: router
            )
            WelcomeView(vm: welcomeViewModel)
            
        case .signUpScreen:
            
            SignUpView(
                vm: SignUpViewModelImpl(
                    with: router
                )
            )
        case .settingScreen:
            SettingsView(vm: SettingViewModelImpl(with: router))
        case .loginScreen:
            let loginViewModel = LoginViewModelImpl(router: router)
            LoginInView(vm: loginViewModel)
            
        case .homeScreen:
            
            HomeView(
                vm: HomeViewViewModelImpl(
                    with: router
                )
            )
        
        }
    }
}

//extension ScreenFactory.Router {
//    func logout() {
//        popToRoot(animated: false) // Optionally clear the stack
//        push(.welcomeScreen)// Push welcome screen
//    }
//}

//extension ScreenFactory.Router {
//    @discardableResult
//    func openAppSettings() -> Succeed {
//        guard
//            let settingsURL = URL(string: UIApplication.openSettingsURLString),
//            UIApplication.shared.canOpenURL(settingsURL)
//        else {
//            return false
//        }
//
//        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
//        return true
//    }
//}


