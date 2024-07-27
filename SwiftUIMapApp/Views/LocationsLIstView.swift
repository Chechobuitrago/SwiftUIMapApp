//
//  LocationsLIstView.swift
//  SwiftUIMapApp
//
//  Created by Sergio Buitrago on 27/07/24.
//

import SwiftUI

struct LocationsLIstView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button(action: {
                    vm.showNextLocation(location: location)
                }, label: {
                    listRowView(location: location)
                })
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    LocationsLIstView()
        .environmentObject(LocationsViewModel())
}


extension LocationsLIstView {
    
    private func listRowView(location: Location) -> some View
    {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            VStack(alignment: .leading) {
                Text(location.name)
                Text(location.cityName)
            }.frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
}
