//
//  ContentView-ViewModel.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 11. 12..
//

import Foundation
import LocalAuthentication
import MapKit

@MainActor class ViewModel: ObservableObject {
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.4521, longitude: 17.0190), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @Published private(set) var locations: [Location]
    @Published var selectedPlace: Location?
    
    let savePath = FileManager.documentsDirectory.appendingPathExtension("SavedPlaces")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            locations = try JSONDecoder().decode([Location].self, from: data)
        } catch {
            locations = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(locations)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Error while saving data")
        }
    }
    
    func update(location: Location) {
        guard let selectedPlace = selectedPlace else { return }
        
        if let index = locations.firstIndex(of: selectedPlace) {
            locations[index] = location
            save()
        }
    }
    
    func addLocation() {
        let newLocation = Location(id: UUID(), name: "Dumcsi", description: "Szokásos edzés előtti lazulás", type: "smoke.fill", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
        locations.append(newLocation)
        save()
    }
    
    func deleteLocation(at offset: IndexSet) {
        locations.remove(atOffsets: offset)
        save()
    }
}


