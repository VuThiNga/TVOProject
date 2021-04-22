//
//  NSObject-ex.swift
//  TVOProject
//
//  Created by Ngavt on 4/16/21.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
