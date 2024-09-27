//
//  Utilities.swift
//  SwiftUIApp
//
//  Created by Muhammad Irfan Zafar on 25/09/2024.
//

import UIKit

class Utilities {
    
    static let shared = Utilities()
    
    private init() { }
    
    func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
