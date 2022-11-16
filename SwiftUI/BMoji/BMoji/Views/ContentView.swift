//
//  ContentView.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 09. 23..
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var userClass = UserClass()
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        
        if viewModel.isUnlocked {
            TabView {
                HomeView(userClass: userClass)
                    .tabItem {
                        Label("Main", systemImage: "person.circle")
                    }
                    .buttonStyle(.borderless)
                
                MapView()
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }
                    .buttonStyle(.borderless)
            }
            .environmentObject(viewModel)
            .environmentObject(userClass)
        } else {
            Button("login") {
                viewModel.authenticate()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
