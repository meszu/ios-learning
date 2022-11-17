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
    @Published var isUnlocked = false
    @Published var selectedPlace: Location?
    
    let savePath = FileManager.documentsDirectory.appendingPathExtension("SavePlace")
    
    init() {
//        do {
//            let data = try Data(contentsOf: savePath)
//            locations = try JSONDecoder().decode([Location].self, from: data)
//        } catch {
//            locations = []
//        }
        
        if let data = UserDefaults.standard.data(forKey: "LocationFile") {
            print("Successfully read the data from UserDefaults")
            if let decoded = try? JSONDecoder().decode([Location].self, from: data) {
                print("Successfully decoded the data")
                locations = decoded
                return
            } else {
                print("failed while decoding")
                locations = []
            }
        } else {
            print("failed while reading data from userdefaults")
            locations = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(locations)
            UserDefaults.standard.set(data, forKey: "LocationFile")
    //        try data.write(to: savePath, options: [.atomic, .completeFileProtection])
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
    
    func deleteLocation(at index: Int) {
        locations.remove(at: index)
        save()
    }
    
    func changeStatus(location: Location, to status: Location.PendingStatus) {
        if let index = locations.firstIndex(of: location) {
            locations[index].pendingStatus = status
        }
        save()
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    Task { @MainActor in
                        self.isUnlocked = true
                    }
                } else {
        
                }
            }
        } else {
            // no biometrics
        }
    }
}


