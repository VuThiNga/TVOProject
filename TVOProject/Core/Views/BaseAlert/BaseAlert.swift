//
//  BaseAlert.swift
//  TVOProject
//
//  Created by Ngavt on 4/15/21.
//

import UIKit

class BaseAlert: BaseVC {

    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var actionStackView: UIStackView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var acceptView: UIView!
    @IBOutlet weak var cancelBtn: BaseButton!
    @IBOutlet weak var acceptBtn: BaseButton!
    
    //constraint
    @IBOutlet weak var titleViewHeightCons: NSLayoutConstraint!
    
    private var acceptAction: (() -> Void)?
    private var cancelAction: (() -> Void)?
    
    var childViewClassName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    func show(_ contentVC: UIViewController,
              title: String? = Constants.APP_NAME,
              actionTitle: String? = nil,
              colorfulButton: Bool = false,
              action: (() -> ())? = nil) {
        childViewClassName = contentVC.className
        presentView()
        
        DispatchQueue.main.async {
            // view title
            if self.titleLb != nil {
                if let ttl = title {
                    self.titleLb.text = ttl
                    self.titleViewHeightCons.constant = 45
                } else {
                    self.titleLb.text = ""
                    self.titleViewHeightCons.constant = 0
                }
            }
            
            // remove all current subviews
            for sub in self.contentView.subviews {
                sub.removeFromSuperview()
            }
            
            // add content
            self.addChild(contentVC)
            self.contentView.addSubview(contentVC.view)
            let frame = self.contentView.frame
            self.contentView.frame = CGRect(origin: frame.origin, size: contentVC.view.frame.size)
            contentVC.view.attach(to: self.contentView)
            
            // action
            if actionTitle != nil {
                if colorfulButton {
                    self.acceptView.isHidden = false
                    self.acceptBtn.setTitle(actionTitle, for: .normal)
                    self.acceptBtn.addTarget(self, action: #selector(self.acceptTapped), for: .touchUpInside)
                    self.acceptAction = action
                } else {
                    self.cancelView.isHidden = false
                    self.cancelBtn.setTitle(actionTitle, for: .normal)
                    self.cancelBtn.addTarget(self, action: #selector(self.cancelTapped), for: .touchUpInside)
                    self.cancelAction = action
                }
            }
        }
    }
    
    func show(msg: String,
              title: String? = Constants.APP_NAME,
              actionTitle: String? = nil,
              colorfulButton: Bool = false,
              action: (() -> ())? = nil,
              parentVC: UIViewController? = nil) {
        presentView(parentVC: parentVC)
        
        DispatchQueue.main.async {
            // view title
            if self.titleLb != nil {
                if let ttl = title {
                    self.titleLb.text = ttl
                    self.titleViewHeightCons.constant = 45
                } else {
                    self.titleLb.text = ""
                    self.titleViewHeightCons.constant = 25
                }
            }
            if self.textView != nil {
                self.textView.text = msg
            }
            
            if actionTitle != nil {
                if colorfulButton {
                    self.acceptView.isHidden = false
                    self.acceptBtn.setTitle(actionTitle, for: .normal)
                    self.acceptBtn.addTarget(self, action: #selector(self.acceptTapped), for: .touchUpInside)
                    self.acceptAction = action
                } else {
                    self.cancelView.isHidden = false
                    self.cancelBtn.setTitle(actionTitle, for: .normal)
                    self.cancelBtn.addTarget(self, action: #selector(self.cancelTapped), for: .touchUpInside)
                    self.cancelAction = action
                }
            }
        }
    }
    
    func showVCTwoOption(_ contentVC: UIViewController,
                         title: String? = Constants.APP_NAME,
                         actionTitle: String? = nil,
                         action: (() -> ())? = nil,
                         cancelTitle: String? = "Cancel".localized,
                         cancel: (() -> Void)? = nil) {
        childViewClassName = contentVC.className
        show(contentVC, title: title, actionTitle: actionTitle, colorfulButton: true, action: action)
        acceptAction = action
        cancelAction = cancel
        DispatchQueue.main.async {
            if cancelTitle != nil {
                self.cancelBtn.setTitle(cancelTitle, for: .normal)
                self.cancelBtn.addTarget(self, action: #selector(self.cancelTapped), for: .touchUpInside)
                self.cancelView.isHidden = false
            }
        }
    }
    
    func showConfirm(msg: String,
                     title: String? = nil,
                     acceptTitle: String,
                     accept: @escaping() -> Void,
                     cancelTitle: String? = "Cancel".localized,
                     cancel: (() -> Void)? = nil,
                     parentVC: UIViewController? = nil) {
        show(msg: msg, title: title, actionTitle: acceptTitle, colorfulButton: true, action: accept, parentVC: parentVC)
        acceptAction = accept
        cancelAction = cancel
        DispatchQueue.main.async {
            if cancelTitle != nil {
                self.cancelBtn.setTitle(cancelTitle, for: .normal)
                self.cancelBtn.addTarget(self, action: #selector(self.cancelTapped), for: .touchUpInside)
                self.cancelView.isHidden = false
            }
        }
    }
    
    @objc private func acceptTapped() {
        hide()
        acceptAction?()
        acceptAction = nil
    }
    
    @objc private func cancelTapped() {
        if let cancel = cancelAction {
            cancel()
            cancelAction = nil
        } else {
            hide()
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.removeFromParent()
            self.view.removeFromSuperview()
        }
    }
    
    private func presentView(parentVC: UIViewController? = nil) {
        DispatchQueue.main.async {
            if var topVC: UIViewController = parentVC ?? UIApplication.topViewController() {
                if let vc = topVC.navigationController {
                    topVC = vc
                } else if let vc = topVC.tabBarController {
                    topVC = vc
                }
                topVC.view.endEditing(true)
                topVC.addChild(self)
                self.view.frame = topVC.view.bounds
                topVC.view.addSubview(self.view)
            }
        }
    }
    
}
