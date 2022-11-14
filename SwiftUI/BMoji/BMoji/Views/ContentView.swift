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
        
        if userClass.user.isLoggedIn {
            TabView {
                HomeView()
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
            LoginView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
