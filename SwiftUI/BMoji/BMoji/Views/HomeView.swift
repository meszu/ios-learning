//
//  HomeView.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 09. 26..
//

import SwiftUI
import MapKit

struct HomeView: View {
    @ObservedObject var userClass: UserClass
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var isShowingChangeUserData = false
    @State private var showingSettings = false
    
    private var pendingLocations: [Location] { return  viewModel.locations.filter { $0.pendingStatus == .pending }
    }
    
    private var acceptedLocations: [Location] { return  viewModel.locations.filter { $0.pendingStatus == .accepted }
    }
    
    private var declinedLocations: [Location] { return  viewModel.locations.filter { $0.pendingStatus == .declined }
    }
    

    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                List {
                    Button("Add example") {
                        viewModel.addLocation()
                    }
                    
                    Section("Accept or Decline") {
                        if pendingLocations.isEmpty {
                            Text("You have no invitation yet.")
                        } else {
                            ForEach(pendingLocations, id: \.id) { location in
                                Text(location.name)
                                    .swipeActions {
                                        Button {
                                            viewModel.changeStatus(location: location, to: .accepted)
                                        } label: {
                                            Label("Accept", systemImage: "checkmark.circle.fill")
                                        }
                                        .tint(.green)
                                        
                                        Button {
                                            viewModel.changeStatus(location: location, to: .declined)
                                        } label: {
                                            Label("Decline", systemImage: "minus.circle.fill")
                                        }
                                        .tint(.pink)
                                    }
                            }
                        }
                        
                        //                        .onDelete(perform: removeItem)
                    }
                    
                    Section("Accepted events") {
                        if acceptedLocations.isEmpty {
                            Text("You have no accepted events.")
                        } else {
                            ForEach(acceptedLocations, id: \.id) { location in
                                NavigationLink {
                                    VStack {
                                        Text(location.name)
                                        Text(location.description)
                                    }
                                } label: {
                                    Text(location.name)
                                }
                            }
                            .onDelete(perform: removeAcceptedLocation)
                        }
                    }
                    
                    Section("Declined events") {
                        if declinedLocations.isEmpty {
                            Text("You do not have any declined events.")
                        } else {
                            ForEach(declinedLocations, id: \.id) { location in
                                Text(location.name)
                            }
                            .onDelete(perform: removeDeclinedLocation)
                        }
                    }
                    
                    Section {
                        Button {
                            Task { @MainActor in
                                viewModel.isUnlocked = false
                            }
                        } label: {
                            Label("Log Out", systemImage: "moon.zzz")
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShowingChangeUserData = true
                        } label: {
                            Image(systemName: "square.and.pencil")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                           showingSettings = true
                        } label: {
                            Image(uiImage: userClass.user.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                        }
                    }
                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $isShowingChangeUserData) {
                    // valamit csinál majd
                }
                .sheet(isPresented: $showingSettings) {
                    SettingsHeaderView()
                }
            }
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        for offset in offsets {
            viewModel.deleteLocation(at: offset)
        }
    }
    
    func removeAcceptedLocation(at offsets: IndexSet) {
        for offset in offsets {
            if let index = viewModel.locations.firstIndex(where: {$0.id == acceptedLocations[offset].id}) {
                viewModel.deleteLocation(at: index)
            }
        }
    }
    
    func removeDeclinedLocation(at offsets: IndexSet) {
        for offset in offsets {
            if let index = viewModel.locations.firstIndex(where: {$0.id == declinedLocations[offset].id}) {
                viewModel.deleteLocation(at: index)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userClass: UserClass())
            .environmentObject(ViewModel())
            .environmentObject(UserClass())
    }
}
