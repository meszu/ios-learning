//
//  FirestoreManager.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 12. 11..
//

import Foundation
import Firebase

class FirestoreManager: ObservableObject {
    @Published var user: User = User(firstName: "Kristóf", lastName: "Mészáros", friends: [], events: [])
    
    init() {
        fetchUser()
        fetchAllUsers()
    }
    
    func fetchUser() {
        let db = Firestore.firestore()
        
        let docRef = db.collection("Users").document("AGEndiL5T2do1v6bFgiN")
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
    //                    print("data", data)
                    self.user.firstName = data["firstName"] as? String ?? "Jane"
                    self.user.lastName = data["lastName"] as? String ?? "Doe"
                    self.user.id = data["id"] as? UUID ?? UUID()
                    self.user.data = data["data"] as? Data
                    self.user.events = data["events"] as? [Location] ?? [Location(id: UUID(), name: "New Location", description: "", type: "💄", latitude: 46.4521, longitude: 17.0190)]
                    self.user.friends = data["friends"] as? [User] ?? [User(firstName: "Luca", lastName: "Nándori", friends: [], events: [])]
                    self.user.isLoggedIn = data["isLoggedIn"] as? Bool ?? false
                }
            }
        }
    }
    
    func fetchAllUsers() {
        let db = Firestore.firestore()
        
        db.collection("Users").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID): \(document.data())")
                }
            }
        }
    }
    
    func createUser(userName: String) {
        let db = Firestore.firestore()
        
        let docRef = db.collection("Users").document(userName)
        
        docRef.setData(["name": userName]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written")
            }
        }
    }
    
    func updateUser(userName: String, firstName: String, lastName: String, id: String, data: String, events: [Location], friends: [User], isLoggedIn: Bool) {
        let db = Firestore.firestore()
        
        let docRef = db.collection("Users").document(userName)
        
        docRef.setData(["firstName": firstName, "lastName": lastName, "id": id, "data": data, "events": events, "friends": friends, "isLoggedIn": isLoggedIn], merge: true) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}
