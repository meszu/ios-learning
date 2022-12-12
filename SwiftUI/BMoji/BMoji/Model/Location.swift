//
//  Location.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 11. 12..
//

import CoreLocation
import SwiftUI

struct Location: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    var type: String
    let latitude: Double
    let longitude: Double
    var pendingStatus: PendingStatus = .pending
    
    enum PendingStatus: Codable {
        case accepted, declined, pending
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(name: "Buckingham Palace", description: "Where the Royal Family lives.", type: "❔", latitude: 46.4521, longitude: 17.0190)
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
