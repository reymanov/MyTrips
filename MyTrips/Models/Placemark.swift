//
//  Placemark.swift
//  MyTrips
//
//  Created by Kuba Rejmann on 16/09/2024.
//

import Foundation
import SwiftData
import MapKit

@Model
class Placemark {
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var destination: Destination?
    
    init(name: String, address: String, latitude: Double, longitude: Double) {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }

}
