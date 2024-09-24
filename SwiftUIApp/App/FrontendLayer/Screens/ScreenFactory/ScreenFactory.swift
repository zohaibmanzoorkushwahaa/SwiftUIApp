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
    
    case loginScreen
}


extension ScreenFactory {
    
    @MainActor
    @ViewBuilder
    func buildScreen(
        router: Router
    ) -> some View {
        switch self {
        
        case .loginScreen: 
            ContentView()
        
        }
    }
}

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

