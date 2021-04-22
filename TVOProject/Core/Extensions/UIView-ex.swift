//
//  UIView-ex.swift
//  TVOProject
//
//  Created by Ngavt on 4/16/21.
//

import UIKit

extension UIView {
    func attach(to container: UIView, top: CGFloat = 0.0, trailing: CGFloat = 0.0, bottom: CGFloat = 0.0, leading: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal,
                               toItem: container, attribute: .top, multiplier: 1.0, constant: top),
            NSLayoutConstraint(item: container, attribute: .trailing, relatedBy: .equal,
                               toItem: self, attribute: .trailing, multiplier: 1.0, constant: trailing),
            NSLayoutConstraint(item: container, attribute: .bottom, relatedBy: .equal,
                               toItem: self, attribute: .bottom, multiplier: 1.0, constant: bottom),
            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal,
                               toItem: container, attribute: .leading, multiplier: 1.0, constant: leading)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

