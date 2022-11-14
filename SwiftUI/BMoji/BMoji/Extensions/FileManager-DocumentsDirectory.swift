//
//  FileManager-DocumentsDirectory.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 11. 12..
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
