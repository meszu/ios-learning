//
//  User.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 11. 13..
//

import Foundation
import UIKit

struct User: Codable, Identifiable {
    var id = UUID()
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
    
    static let example = User(firstName: "Kristóf", lastName: "Mészáros", friends: [], events: [])
}

class UserClass: ObservableObject {
    @Published var user: User
    
    private let savePath = FileManager.documentsDirectory.appendingPathComponent("UserProfile")
    
    init() {
        // Using Documents Directory
        
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(User.self, from: data) {
                user = decoded
                print("Successfully loaded data from UserProfile")
                return
            }
        }
        
        // Using User Defaults:
//        if let data = UserDefaults.standard.data(forKey: "UserFile") {
//            print("Successfully read the data from UserDefaults")
//            if let decoded = try? JSONDecoder().decode(User.self, from: data) {
//                print("Successfully decoded the data")
//                user = decoded
//                return
//            }
//        }
        print("No data, not decoded")
        user = User.example
    }
}
