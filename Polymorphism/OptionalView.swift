//
//  OptionalView.swift
//  Polymorphism
//
//  Created by Ouimin Lee on 10/14/24.
//

import SwiftUI
import SwiftData
import CoreLocation

struct OptionalView: View {
    let manager = CLLocationManager()
    @Environment(\.modelContext) private var modelContext
    @Query private var rogueOnes: [RogueOne]
    @State private var showAlert = false
    
    var body: some View {
        NavigationSplitView {
            if let coordinate = manager.location?.coordinate {
                Text("Latitude: \(coordinate.latitude)")
                
                Text("Longitude: \(coordinate.longitude)")
            } else {
                Text("Unknown Location")
            }
            Button("Get location") {
                manager.requestWhenInUseAuthorization()
            }
            .buttonStyle(.borderedProminent)
            
            List {
                ForEach(rogueOnes) { location in
                    NavigationLink {
                        Text("Location at \(location.latitude!), \(location.longitude!)")
                    } label: {
                        Text("Lat: \(location.latitude!), Lon: \(location.longitude!)")
                    }
                }
                .onDelete(perform: deleteLocations)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addCurrentLocation) {
                        Label("Add Current Location", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a location")
        }
        .onAppear{
            manager.requestWhenInUseAuthorization()
    }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Unable to fetch current location."), dismissButton: .default(Text("OK")))
        }
    }

    private func addCurrentLocation() {
        withAnimation {
            if let coordinate = manager.location?.coordinate {
                modelContext.insert(RogueOne(latitude: coordinate.latitude, longitude: coordinate.longitude))
            } else {
                showAlert = true // Trigger the alert if location is unavailable
            }
        }
    }
    
    private func deleteLocations(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(rogueOnes[index])
            }
        }
    }
}

#Preview {
    OptionalView()
        .modelContainer(for: RogueOne.self, inMemory: true)
}
