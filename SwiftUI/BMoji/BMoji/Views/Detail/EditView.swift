//
//  EditView.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 11. 12..
//

import SwiftUI

struct EditView: View {
    @State private var isShowingConfirmationDialog = false
    @State private var showEmojiGrid = false
    
    @State private var currentMeetingType = "❔"
    
    let emojis = ["🧠", "🏎️", "🎥", "💈", "🚬", "💉", "❔"]
    
    @EnvironmentObject var originalVM: ViewModel
    
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    
    @StateObject private var viewModel: EditViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section("Edit name and description") {
                    TextField("Meeting's name", text: $viewModel.name)
                        .textFieldStyle(.automatic)
                    TextEditor(text: $viewModel.description)
                        .textFieldStyle(.automatic)
                }
                
                Picker("Meeting type", selection: $viewModel.type) {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji)
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
        }
        
    }


    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
    
        _viewModel = StateObject(wrappedValue: EditViewModel(location: location))
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in }
    }
}
                 
                 
