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
     
                    HeaderView()
                        .frame(width: proxy.size.width)
                        .listRowBackground(Color.yellow)

                    Button("Add example") {
                        viewModel.addLocation()
                    }
                    
                    Section("Accept or Decline") {
                        ForEach(pendingLocations, id: \.id) { location in
                            Text(location.name)
                                .swipeActions {
                                    Button {
                                        viewModel.changeStatus(location: location, to: .accepted)
                                    } label: {
                                        Image(systemName: "checkmark.circle")
                                    }
                                    
                                    Button {
                                        viewModel.changeStatus(location: location, to: .declined)
                                    } label: {
                                        Image(systemName: "minus.circle")
                                    }
                                }
                        }
//                        .onDelete(perform: removeItem)
                    }
                    
                    Section("Accepted events") {
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
                        .onDelete(perform: removeItem)
                    }
                    
                    Section("Declined events") {
                        ForEach(declinedLocations, id: \.id) { location in
                            Text(location.name)
                        }
                        .onDelete(perform: removeItem)
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
                    Button {
                        isShowingChangeUserData = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
                .navigationTitle("Profile")
                .sheet(isPresented: $isShowingChangeUserData) {
                    ChangeUserData()
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

struct HeaderView: View {
    @EnvironmentObject var userClass: UserClass
    var body: some View {
        HStack(alignment: .top, spacing: 24) {
            Image(uiImage: userClass.user.image)
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(20)
                .padding(.leading, 30)

            VStack(alignment: .leading) {
                Text(userClass.user.firstName)
                    .font(.title)
                    .foregroundColor(.secondary)
                Text(userClass.user.lastName)
                    .font(.largeTitle)
                    .foregroundColor(.black)
            }
            
            Spacer()
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
