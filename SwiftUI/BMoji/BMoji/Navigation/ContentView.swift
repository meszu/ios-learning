//
//  ContentView.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 09. 23..
//

import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var userClass: UserClass
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var model: Model
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @AppStorage("showAccount") var showAccount = false
    
    init() {
        showAccount = false
    }
    
    var body: some View {
        
        if viewModel.isUnlocked {
            ZStack {
                Group {
                    switch selectedTab {
                    case .home:
                        HomeView(userClass: userClass)
                    case .explore:
                        MapView()
                    case .notifications:
                        Text("coming soon")
                    case .friends:
                        VStack {
                            Image(systemName: "person.3")
                                .font(.largeTitle)
                                .foregroundStyle(.blue)
                            Text("Coming soon...")
                        }
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    VStack {}.frame(height: 44)
                }
                
                TabBar()
                
                if model.showModal {
                    ModalView()
                        .accessibilityIdentifier("Identifier")
                }
            }
            .dynamicTypeSize(.large ... .xxLarge)
            .sheet(isPresented: $showAccount) {
                AccountView()
            }
        } else {
            ModalView()
        }
                
//        if viewModel.isUnlocked {
//            TabView {
//                HomeView(userClass: userClass)
//                    .tabItem {
//                        Label("Main", systemImage: "person.circle")
//                    }
//                    .buttonStyle(.borderless)
//
//                MapView()
//                    .tabItem {
//                        Label("Map", systemImage: "map")
//                    }
//                    .buttonStyle(.borderless)
//            }
//            .environmentObject(viewModel)
//            .environmentObject(userClass)
//        } else {
//            Button("login") {
//                viewModel.authenticate()
//            }
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
