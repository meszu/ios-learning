//
//  StringExtension.swift
//  TesztFeladat
//
//  Created by Mészáros Kristóf on 2022. 01. 17..
//

import Foundation

extension String {
    func subString(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex..<endIndex])
    }
}
