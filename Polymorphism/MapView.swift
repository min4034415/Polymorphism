//
//  MapView.swift
//  Polymorphism
//
//  Created by Ouimin Lee on 10/14/24.
//

import SwiftUI
import MapKit
import SwiftData

struct MapView: View {
    let manager = CLLocationManager()
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
        }
        .mapControls(){
            MapUserLocationButton()
        }
        .onAppear {
            manager.requestWhenInUseAuthorization()
        }
    }
}

#Preview {
    MapView()
}
