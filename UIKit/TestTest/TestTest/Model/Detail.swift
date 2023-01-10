//
//  Detail.swift
//  TestTest
//
//  Created by Mészáros Kristóf on 2023. 01. 07..
//

import Foundation

struct Detail: Codable {
    var id: Int
    var name: String
    var shortDescription: String
    var description: String
}

struct Section {
  let title: String
  let cells: [Offer]
}
