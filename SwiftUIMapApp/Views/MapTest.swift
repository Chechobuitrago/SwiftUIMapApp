//
//  MapTest.swift
//  SwiftUIMapApp
//
//  Created by Sergio Buitrago on 27/07/24.
//

import SwiftUI
import MapKit

struct MapTest: View {
    @EnvironmentObject private var vm: LocationsViewModel
    @State private var position: MapCameraPosition = .userLocation(
        fallback: .camera(
            MapCamera(centerCoordinate: .rome, distance: 1000)
    ))
    var body: some View {
        Map(position: $position, interactionModes: .pitch)
    }
}

#Preview {
    MapTest()
}


extension CLLocationCoordinate2D {
    static let rome: Self = .init(
        latitude: 41.8902, longitude: 12.4922
    )
}
