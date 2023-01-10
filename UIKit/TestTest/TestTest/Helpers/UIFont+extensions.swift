//
//  UIFont+extensions.swift
//  TestTest
//
//  Created by Mészáros Kristóf on 2023. 01. 09..
//

import UIKit

extension UIFont {
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        UIFont.systemFont(ofSize: pointSize, weight: weight)
    }
}
