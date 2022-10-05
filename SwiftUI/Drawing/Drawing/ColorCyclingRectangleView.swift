//
//  ColorCyclingRectangleView.swift
//  Drawing
//
//  Created by Mészáros Kristóf on 2022. 10. 05..
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var gradientStartX = 0.5
    var gradientStartY = 0.0
    var gradientEndX = 0.5
    var gradientEndY = 1.0
    
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(colors: [
                            color(for: value, brightness: 1),
                            color(for: value, brightness: 0.5)
                        ],
                        startPoint: UnitPoint(x: gradientStartX, y: gradientStartY),
                        endPoint: UnitPoint(x: gradientEndX, y: gradientEndY))
                    )
            }
            .drawingGroup()
        }
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangleView: View {
    @State private var colorCycle = 0.0
    
    @State private var gradientStartX = 0.5
    @State private var gradientStartY = 0.0
    @State private var gradientEndX = 0.5
    @State private var gradientEndY = 1.0
    
    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: colorCycle, gradientStartX: gradientStartX, gradientStartY: gradientStartY, gradientEndX: gradientEndX, gradientEndY: gradientEndY)
                .frame(width: 300, height: 300)
            
            HStack {
                Text("Color")
                Slider(value: $colorCycle)
            }
            
            HStack {
                Text("StartX")
                Slider(value: $gradientStartX)
            }
            
            HStack {
                Text("StartY")
                Slider(value: $gradientStartY)
            }
            
            HStack {
                Text("EndX")
                Slider(value: $gradientEndX)
            }
            
            HStack {
                Text("EndY")
                Slider(value: $gradientEndY)
            }
        }
    }
}

struct ColorCyclingRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangleView()
    }
}
