//
//  LocationsViewModel.swift
//  SwiftUIMapApp
//
//  Created by Sergio Buitrago on 26/07/24.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    // Current location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapPosition(location: mapLocation)
        }
    }
    // Current region on map
    @Published var mapPosition: MapCameraPosition = .region(MKCoordinateRegion())
    

    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    
    // Show list of locations
    @Published var showLocationsList: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapPosition(location: locations.first!)
    }
    
    private func updateMapPosition(location: Location) {
        withAnimation(.easeInOut) {
            mapPosition = .region( MKCoordinateRegion(center: location.coordinates, span: mapSpan))
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        // Get de current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Could not find current index in location")
            return
        }
        
        // Check if the currentIndex is valid
        let nextIndex = currentIndex + 1
        
        guard locations.indices.contains(nextIndex) else {
            
            // Next index is NOT valid
            // Restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        //Next index IS valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
