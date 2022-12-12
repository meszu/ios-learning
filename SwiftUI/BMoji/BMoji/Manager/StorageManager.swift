//
//  StorageManager.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 12. 11..
//

import SwiftUI
import Firebase
import FirebaseStorage

class StorageManager: ObservableObject {
    let storage = Storage.storage()
    
    func upload(image: UIImage) {
        let storageRef = storage.reference().child("images/image.jpg")
        let resizedImage = image.aspectFittedToHeight(200)
        let data = resizedImage.jpegData(compressionQuality: 0.2)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }
                
                if let metadata = metadata {
                    print("Metadata: ", metadata)
                }
            }
        }
    }
    
    func listAllFiles() {
        let storageRef = storage.reference().child("images")
        
        storageRef.listAll { (result, error) in
            if let error = error {
                print("Error while listing all the fiels: ", error)
            }
            
            for item in result!.items {
                print("Item in images folder: ", item)
            }
        }
    }
}
