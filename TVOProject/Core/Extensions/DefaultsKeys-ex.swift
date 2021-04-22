//
//  DefaultsKeys-ex.swift
//  TVOProject
//
//  Created by Ngavt on 4/15/21.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    var selected_language: DefaultsKey<String?> { .init("selected_language", defaultValue: Locale.current.languageCode) }
}
