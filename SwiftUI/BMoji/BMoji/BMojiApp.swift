//
//  BMojiApp.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 09. 23..
//

import Firebase
import SwiftUI

@main
struct BMojiApp: App {
    @StateObject var firestoreManager = FirestoreManager()
    @StateObject var model = Model()
    @StateObject var userClass = UserClass()
    @StateObject var viewModel = ViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firestoreManager)
                .environmentObject(model)
                .environmentObject(userClass)
                .environmentObject(viewModel)
        }
    }
}
