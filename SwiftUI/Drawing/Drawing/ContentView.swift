//
//  ContentView.swift
//  Drawing
//
//  Created by Mészáros Kristóf on 2022. 10. 03..
//

import SwiftUI




struct ContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Try Spinograph", destination: SpinographView())
                NavigationLink("Try AnimatablePair", destination: AnimatablePairView())
                NavigationLink("Arrow with growing lineWidth", destination: ArrowView())
                NavigationLink("Messing with Color Cycling Rectangles", destination: ColorCyclingRectangleView())
            }
            .navigationTitle("Drawing App")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
