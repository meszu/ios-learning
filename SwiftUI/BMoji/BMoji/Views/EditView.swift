//
//  EditView.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 11. 12..
//

import SwiftUI

enum MeetingType: CaseIterable {
    case jim
    case smoke
    case none
}

struct EditView: View {
    @State private var selectedType: MeetingType = .none
    @State private var isShowingConfirmationDialog = false
    
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    
    @StateObject private var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section("Edit name and description") {
                    TextField("Meeting's name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("select meeting type") {
                    Button("Click here to select meeting type") {
                        isShowingConfirmationDialog = true
                    }
                }
            }
            .navigationTitle("Add details")
            .toolbar {
                Button("Save") {
                    let newLocation = viewModel.createNewLocation()
                    onSave(newLocation)
                    dismiss()
                }
            }
            .confirmationDialog("Select Meeting Type", isPresented: $isShowingConfirmationDialog) {
                Button {
                    viewModel.type = "JIM"
                } label: {
                    Label("JIM", systemImage: "figure.gymnastics")
                }
                .foregroundColor(selectedType == .jim ? .green : .blue)
                
                Button {
                    viewModel.type = "Smoke"
                } label: {
                    Label("Smoke", systemImage: "smoke")
                }
                .foregroundColor(selectedType == .smoke ? .green : .blue)
                
                Button {
                    viewModel.type = "None"
                } label: {
                    Label("Don't know yet", systemImage: "questionmark.circle.fill")
                }
                .foregroundColor(selectedType == .none ? .green : .blue)
            }
        }
        
    }


    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
    
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in }
    }
}
                 
                 
