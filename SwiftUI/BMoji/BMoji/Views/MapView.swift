//
//  MapView.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 11. 12..
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var viewModel: ViewModel
        
    var body: some View {
        ZStack {
            map
            
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(.yellow.opacity(0.4))
            
            addButton
        }
        .ignoresSafeArea(edges: .top)
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) { newLocation in
                viewModel.update(location: newLocation)
            }
        }
        
    }
    
    var map: some View {
        Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                VStack {
                    MapBalloon(shape: location.type, strokeColor: location.annotationItemColor)
                    
                    Text("\(location.name)")
                        .fixedSize()
                }
                .onTapGesture {
                    viewModel.selectedPlace = location
                }
            }
        }
    }
    
    var addButton: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    // create a new location
                    viewModel.addLocation()
                } label: {
                    Image(systemName: "plus")
                        .padding()
                        .background(.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                }
                .buttonStyle(.borderless)
                
                Spacer()
            }
            .padding(.bottom, 30)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(ViewModel())
    }
}
