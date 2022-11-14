//
//  ChangeUserData.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 11. 13..
//

import SwiftUI

struct ChangeUserData: View {
    @EnvironmentObject var userClass: UserClass
    
    @Environment(\.dismiss) var dismiss
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var picName = ""
    @State private var isReadyForSave = false
    
    private let savePath = FileManager.documentsDirectory.appendingPathExtension("SavedUser")
    
    var body: some View {
        NavigationView {
            Form {
                Section("Change your name") {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }
                
                VStack {
                    HStack {
                            if image != nil {
                                image?
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(20)
                                    .padding()
                            } else {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(20)
                                    .padding()
                            }
                            
                            Spacer()
                            
                            Button("Select") {
                                showingImagePicker = true
                            }
                            .padding()
                    }
                    
                    Button("Save", action: save)
                    .buttonStyle(GrowingButton())
                }
            }
            .toolbar {
                Button("Dismiss") {
                    dismiss()
                }
            }
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
    }
    
    func save() {
        guard let inputImage = inputImage else { return }
        
        if let jpegData = inputImage.jpegData(compressionQuality: 0.8) {
            userClass.user.data = jpegData
            userClass.user.firstName = firstName
            userClass.user.lastName = lastName
            print("Successfully created Item")
        } else {
            print("Unable to save jpeg as data.")
            return
        }
        
        
        do {
            let data = try JSONEncoder().encode(userClass.user)
            UserDefaults.standard.set(data, forKey: "UserFile")
//            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            print("Successfully saved data")
        } catch {
            print("Unable to save data.")
        }
        
        dismiss()
    }
    
    func checkForSaving() {
        if image != nil && !firstName.isEmpty && !lastName.isEmpty {
            isReadyForSave = true
        } else {
            isReadyForSave = false
        }
    }
}

struct ChangeUserData_Previews: PreviewProvider {
    static var previews: some View {
        ChangeUserData()
            .environmentObject(UserClass())
    }
}
