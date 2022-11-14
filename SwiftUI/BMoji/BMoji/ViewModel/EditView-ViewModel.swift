//
//  EditView-ViewModel.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 11. 12..
//

import SwiftUI

extension EditView {
    @MainActor class ViewModel: ObservableObject {
        enum LoadingState {
            case loading, loaded, failed
        }
        
        @Published var name: String
        @Published var description: String
        @Published var type: String
        
        @Published var loadingState = LoadingState.loading
        
        var location: Location
        
        init(location: Location) {
            name = location.name
            description = location.description
            type = location.type
            self.location = location
        }
        
        func createNewLocation() -> Location {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            newLocation.type = type
            
            return newLocation
        }
    }
}
