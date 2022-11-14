//
//  User.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 11. 13..
//

import Foundation
import UIKit

struct User: Codable, Identifiable {
    var id: UUID
    var firstName: String
    var lastName: String
    var friends: [User]
    var events: [Location]
    var isLoggedIn = true
    var data: Data?
    
    var image: UIImage {
        guard let data = data else { return UIImage(systemName: "person.circle")! }
        let uIImage: UIImage = UIImage(data: data) ?? UIImage(systemName: "circle")!
        return uIImage
    }
    
    static let example = User(id: UUID(), firstName: "Kristóf", lastName: "Mészáros", friends: [], events: [])
}

class UserClass: ObservableObject {
    @Published var user: User
//    @Published var id: UUID
//    @Published var firstName: String
//    @Published var lastName: String
//    @Published var friends: [User]
//    @Published var events: [Location]
//    @Published var isLoggedIn = true
//    @Published var data: Data?
    
    init() {
        if let data = try? Data(contentsOf: FileManager.documentsDirectory.appendingPathComponent("SavedUser")) {
            if let decoded = try? JSONDecoder().decode(User.self, from: data) {
                user = decoded
                print("Successfully loaded data from SavedUser")
                return
            }
        }
        user = User.example
    }
}
