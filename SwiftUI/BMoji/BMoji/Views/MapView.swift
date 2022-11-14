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
            Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        MapBalloon(shape: location.imageName, strokeColor: location.annotationItemColor)
//                        Image(systemName: location.imageName)
//                            .resizable()
//                            .foregroundColor(location.annotationItemColor)
//                            .frame(width: 44, height: 44)
//                            .padding(2)
//                            .background(.white)
//                            .clipShape(Circle())
                        
                        Text("\(location.name)")
                            .fixedSize()
                    }
                    .onTapGesture {
                        viewModel.selectedPlace = location
                    }
                }
            }
//            .onLongPressGesture {
//                viewModel.selectedPlace = location
//            }
            
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(.yellow.opacity(0.4))
            
            VStack {
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
                            .padding(.trailing)
                            .padding(.top)
                    }
                    .buttonStyle(.borderless)
                }
                
                Spacer()
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) { newLocation in
                viewModel.update(location: newLocation)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(ViewModel())
    }
}
