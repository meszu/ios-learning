//
//  ArrowView.swift
//  Drawing
//
//  Created by Mészáros Kristóf on 2022. 10. 04..
//

import SwiftUI

struct Arrow: Shape {
    var lineWidth: Double
    
    var animatableData: Double {
        get { lineWidth }
        set { lineWidth = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.maxX / 4 * 3, y: rect.maxY / 3))
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.maxX / 4, y: rect.maxY / 3))
       // path.addLine(to: CGPoint(x: rect.maxX / 4 * 3, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.maxX / 4, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX / 4 * 3, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX / 4 * 3, y: rect.maxY / 3))

        
        return path
    }
    
}

struct ArrowView: View {
    @State private var lineWidth: Double = 2.0
    
    var body: some View {
        VStack {
            Spacer()
            
            Arrow(lineWidth: lineWidth)
                .stroke(.blue, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300)
                .onTapGesture {
                    withAnimation {
                        lineWidth += 10
                    }
                }
            
            
            Spacer()
            
            Slider(value: $lineWidth, in: 1...20)
            
            Spacer()
        }
        
            
            
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
