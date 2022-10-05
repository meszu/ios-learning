//
//  DecimalUtil.swift
//  Bankey
//
//  Created by Mészáros Kristóf on 2022. 04. 20..
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
