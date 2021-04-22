//
//  String-ex.swift
//  TVOProject
//
//  Created by Ngavt on 4/15/21.
//

import Foundation
import SwiftyUserDefaults

extension String {
    var localized: String {
        if let selected = Defaults.selected_language, let path = Bundle.main.path(forResource: selected, ofType: "lproj"), let bundle = Bundle(path: path) {
            
            return NSLocalizedString(self, tableName: Constants.localizationFile, bundle: bundle, value: "", comment: "")
        }
        return NSLocalizedString(self, tableName: Constants.localizationFile, bundle: Bundle.main, value: "", comment: "")
    }

    var trimSpace: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func unaccent() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }

    func substring(from: Int, to: Int) -> String? {
        if from < 0 || to > count {
            return nil
        }
        
        let str = index(startIndex, offsetBy: from)
        let end = index(endIndex, offsetBy: to - count)

        return String(self[str..<end])
    }
}
