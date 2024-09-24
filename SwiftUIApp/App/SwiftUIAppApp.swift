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
            ContentView()
        }
    }
}
