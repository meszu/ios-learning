//
//  MapBalloon.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 11. 13..
//

import SwiftUI

struct MapBalloonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY), control: CGPoint(x: rect.maxX, y: rect.minY))
        
        return path
    }
}

struct MapBalloon: View {
    let lineWidth: Double = 5.0
    var shape: String
    var strokeColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(strokeColor.opacity(0.4))
                .frame(width: 64, height: 64)

            Text(shape)
                .padding(2)
                .font(.largeTitle)
        }
    }
}

struct MapBalloon_Previews: PreviewProvider {
    static var previews: some View {
        MapBalloon(shape: "star.fill", strokeColor: .black)
    }
}
