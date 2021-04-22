//
//  BaseLabel.swift
//  TVOProject
//
//  Created by Ngavt on 4/16/21.
//

import UIKit

@IBDesignable
class BaseLabel: UILabel {
    @IBInspectable var englishText: String? {
        get {
            return text?.localized
        }
        set {
            text = newValue?.localized
        }
    }
    @IBInspectable var strokeWidth: CGFloat = 0 {
        didSet {
            refreshStroke()
        }
    }
    @IBInspectable var strokeColor: UIColor = .clear {
        didSet {
            refreshStroke()
        }
    }
    @IBInspectable var foregroundColor: UIColor? {
        didSet {
            refreshStroke()
        }
    }
    
    private func refreshStroke() {
        guard let text = text else {
            return
        }
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: strokeColor,
            NSAttributedString.Key.foregroundColor: foregroundColor ?? textColor!,
            NSAttributedString.Key.strokeWidth: -strokeWidth,
            NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 15)
        ]

        attributedText = NSMutableAttributedString(string: text.localized, attributes: strokeTextAttributes)
    }
}
