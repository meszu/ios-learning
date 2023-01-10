//
//  Offer.swift
//  TestTest
//
//  Created by Mészáros Kristóf on 2023. 01. 07..
//

import Foundation
import UIKit

struct Offer: Codable {
    var id: String
    var rank: Int
    var isSpecial: Bool
    var name: String
    var shortDescription: String
}
