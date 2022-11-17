//
//  HomeView-HeaderView.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 11. 17..
//

import SwiftUI

struct SettingsHeaderView: View {
    @EnvironmentObject var userClass: UserClass
    @Environment(\.dismiss) var dismiss
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    private let savePath = FileManager.documentsDirectory.appendingPathComponent("UserProfile")
    
    var body: some View {
        List {
            HStack {
                Spacer()
                
                VStack {
                    ZStack(alignment: .bottomTrailing) {
                        Circle()
                            .stroke(.black, style: StrokeStyle(lineWidth: 5))
                            .frame(width: 100, height: 100)
                        
                        
                        Image(uiImage: userClass.user.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        
                    
        
                        Circle()
                            .frame(width: 30, height: 30)
                            .offset(x: 0, y: -5)
                        Image(systemName: "camera.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .offset(x: 0, y: -5)
                            .foregroundStyle(.blue)
                        
                    }
                    .onTapGesture {
                        showingImagePicker.toggle()
                    }
                    
                    HStack {
                        Text(userClass.user.firstName)
                            .font(.title)
                            .foregroundColor(.secondary)
                        Text(userClass.user.lastName)
                            .font(.title.bold())
                            .foregroundColor(.primary)
                    }
                }
                
                Spacer()
            }
            .onChange(of: inputImage) { _ in loadImage() }
            .onChange(of: inputImage) { _ in save() }
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
            //            userClass.user.firstName = firstName
            //            userClass.user.lastName = lastName
            print("Successfully created Item")
        } else {
            print("Unable to save jpeg as data.")
            return
        }
        
        
        do {
            let data = try JSONEncoder().encode(userClass.user)
            // Using User Default:
            //            UserDefaults.standard.set(data, forKey: "UserFile")
            
            // Using Documents Directory:
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            print("Successfully saved data")
        } catch {
            print("Unable to save data.")
        }
        
        dismiss()
    }
    
}

struct SettingsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsHeaderView()
            .environmentObject(UserClass())
    }
}
