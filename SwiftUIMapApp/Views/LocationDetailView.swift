//
//  LocationDetailView.swift
//  SwiftUIMapApp
//
//  Created by Sergio Buitrago on 28/07/24.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
    
            ScrollView {
                VStack {
                    imageSection
                        .shadow(color: .black.opacity(0.3), radius: 20, x: 0.0, y: 10)
                    
                    VStack(alignment: .leading, spacing: 16){
                        titleSection
                        Divider()
                        descriptionSection
                        Divider()
                        mapLayer
                        
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                    .padding()
                }
            }
            .ignoresSafeArea()
            .background(.ultraThinMaterial)
            .overlay(alignment: .topLeading) {
                backButton
            }
        
    }
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}


extension LocationDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil :
                            UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16){
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            if let url = URL(string: location.link)
            {
                Link("Read more on Wikipedia", destination: url )
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }
    
    private var mapLayer: some View {
        
        let pos: MapCameraPosition = .region(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
        
        return Map(position: .constant(pos)){
            ForEach([location]) { location in
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationAnnotationView()
                        .shadow(radius: 10)
                }
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
    }
    
    private var backButton: some View {
        Button(action: {vm.sheetLocation = nil}, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(14)
                .foregroundStyle(.primary)
                .background(.thickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 4)
                .padding()
        }).buttonStyle(PlainButtonStyle())
    }
}
