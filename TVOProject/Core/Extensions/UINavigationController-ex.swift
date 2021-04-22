//
//  UINavigationController-ex.swift
//  TVOProject
//
//  Created by Ngavt on 4/16/21.
//

import UIKit

extension UINavigationController {
    func makeTransparent() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        view.backgroundColor = .clear
    }
}
