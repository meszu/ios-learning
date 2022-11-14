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

    var body: some View {
        NavigationView {
            List {
                Section {
                    HeaderView()
                }
                
                Button("Add example") {
                    viewModel.addLocation()
                }
                
                Section("Accept or Decline") {
                    ForEach(viewModel.locations) { location in
                        Text(location.name)
                    }
                    .onDelete(perform: removeItem)
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
    
    func removeItem(at offsets: IndexSet) {
        viewModel.deleteLocation(at: offsets)
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
            
            VStack(alignment: .leading) {
                Text(userClass.user.firstName)
                    .font(.title)
                    .foregroundColor(.secondary)
                Text(userClass.user.lastName)
                    .font(.largeTitle)
                    .foregroundColor(.black)
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
