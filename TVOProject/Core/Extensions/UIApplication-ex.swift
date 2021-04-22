//
//  UIApplication-ex.swift
//  TVOProject
//
//  Created by Ngavt on 4/16/21.
//

import UIKit

extension UIApplication {
    // MARK: Find topViewController
    /**
        - Parameters:
            - viewController: current view controller, default is rootViewController
     */
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        return viewController
    }
}
