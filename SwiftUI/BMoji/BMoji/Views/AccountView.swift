//
//  HomeView-HeaderView.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 11. 17..
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var userClass: UserClass
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    private let savePath = FileManager.documentsDirectory.appendingPathComponent("UserProfile")
    
    var body: some View {
        NavigationView {
            List {
                profile
                
                menu
                
                Section {
                    Button {
                        Task { @MainActor in
                            viewModel.isUnlocked = false
                        }
                    } label: {
                        Label("Log Out", systemImage: "moon.zzz")
                    }
                    .foregroundStyle(.primary)
                }
                .onChange(of: inputImage) { _ in loadImage() }
                .onChange(of: inputImage) { _ in save() }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    var profile: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                
                Image(uiImage: userClass.user.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding()
                    .background(Circle().fill(.ultraThinMaterial))
                    .background(
                        Image(systemName: "hexagon")
                            .symbolVariant(.fill)
                            .foregroundColor(.blue)
                            .font(.system(size: 200))
                            .offset(x: -50, y: -100)
                    )

                ZStack {
                    Circle()
                        .foregroundStyle(.white)
                        .frame(width: 35, height: 35)
                    
                    Image(systemName: "camera.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.blue)
                }
                .offset(x: -15, y: -15)
                
                
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
            
            HStack {
                Image(systemName: "location")
                    .imageScale(.small)
                Text("Nagykanizsa")
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    var menu: some View {
        Section {
            NavigationLink {
                VStack {
                    Text(userClass.user.firstName)
                    Text(userClass.user.lastName)
                }
            } label: {
                Label("Settings", systemImage: "gear")
            }
            
            NavigationLink {
                Image(systemName: "x.circle")
                    .font(.largeTitle)
                    .padding()
                Text("Coming soon...")
            } label: {
                Label("Billing", systemImage: "creditcard")
            }
            
            NavigationLink {
                Text("Help yourself and God will help you")
            } label: {
                Label("Help", systemImage: "questionmark")
            }
        }
        .foregroundStyle(.primary)
        .listRowSeparator(.hidden)
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
    }
    
}

struct SettingsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(UserClass())
            .environmentObject(ViewModel())
    }
}
