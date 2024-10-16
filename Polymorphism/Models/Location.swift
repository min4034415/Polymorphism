//
//  Location.swift
//  Polymorphism
//
//  Created by Ouimin Lee on 9/10/24.
//

import SwiftData
import CoreLocation

@Model
final class Location {
    var id: UUID?
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
    
    init(latitude: Double, longitude: Double, id: UUID) {
        self.latitude = latitude
        self.longitude = longitude
        self.id = UUID()
    }
}
