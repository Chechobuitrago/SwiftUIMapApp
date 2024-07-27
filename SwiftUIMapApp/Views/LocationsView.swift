//
//  LocationsView.swift
//  SwiftUIMapApp
//
//  Created by Sergio Buitrago on 26/07/24.
//

import SwiftUI
import MapKit


struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    @State private var region = MKCoordinateRegion()
    
    
    var body: some View {
        ZStack {
            Map(initialPosition: vm.mapPosition)
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
