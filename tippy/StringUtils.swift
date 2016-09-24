//
//  StringUtils.swift
//  tippy
//
//  Created by SangHoon Lee on 9/18/16.
//  Copyright © 2016 SangHoon Lee. All rights reserved.
//

import Foundation

struct StringUtils {
    
    static let EMPTY_STRING = ""
    static let NUMBER_FORMATTER = NSNumberFormatter()
    
    static func formatToLocaleCurrencyString(amount: Double) -> String {
        NUMBER_FORMATTER.numberStyle = .CurrencyStyle
        NUMBER_FORMATTER.locale = NSLocale.currentLocale()
        return NUMBER_FORMATTER.stringFromNumber(amount) ?? EMPTY_STRING
    }
}