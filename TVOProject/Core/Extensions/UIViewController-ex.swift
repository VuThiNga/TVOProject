//
//  UIViewController-ex.swift
//  TVOProject
//
//  Created by Ngavt on 4/16/21.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showLoading(_ msg: String? = nil) {
        hideLoading()
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            if let m = msg {
                hud.label.text = m
            }
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func showAlert(_ msg: String,
                   title: String = Constants.APP_NAME,
                   actionTitle: String = "Close".localized,
                   colorfulButton: Bool = true,
                   action: (() -> ())? = nil,
                   parentVC: UIViewController? = nil) {
        DispatchQueue.main.async {
            let vc = BaseAlert(nibName: "BaseAlert", bundle: nil)
            vc.show(msg: msg, title: title, actionTitle: actionTitle, colorfulButton: colorfulButton, action: action, parentVC: parentVC)
        }
    }
    
    func showAlert(_ contentVC: UIViewController,
                   title: String? = Constants.APP_NAME,
                   actionTitle: String? = nil,
                   colorfulButton: Bool = true,
                   action: (() -> ())? = nil) {

        DispatchQueue.main.async {
            let vc = BaseAlert(nibName: "BaseAlert", bundle: nil)
            vc.show(contentVC, title: title, actionTitle: actionTitle, colorfulButton: colorfulButton, action: action)
        }
    }
    
    func showConfirm(_ msg: String,
                     title: String = Constants.APP_NAME,
                     acceptTitle: String = "Accept".localized,
                     cancelTitle: String = "Cancel".localized,
                     accept: @escaping() -> Void,
                     cancel: (() -> Void)? = nil, parentVC: UIViewController? = nil) {
        
        DispatchQueue.main.async {
            let vc = BaseAlert(nibName: "BaseAlert", bundle: nil)
            vc.showConfirm(msg: msg,
                           title: title,
                           acceptTitle: acceptTitle,
                           accept: accept,
                           cancelTitle: cancelTitle,
                           cancel: cancel,
                           parentVC: parentVC)
        }
    }
}
