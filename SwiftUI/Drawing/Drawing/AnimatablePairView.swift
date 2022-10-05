//
//  AnimatablePair.swift
//  Drawing
//
//  Created by Mészáros Kristóf on 2022. 10. 03..
//

import SwiftUI

struct CheckerBoard: Shape {
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let columSize = rect.width / Double(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    let startX = columSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columSize, height: rowSize)
                    
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}

struct AnimatablePairView: View {
    @State private var rows = 4
    @State private var columns = 4
    
    var body: some View {
        CheckerBoard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    rows = 8
                    columns = 8
                }
            }
    }
}

struct AnimatablePair_Previews: PreviewProvider {
    static var previews: some View {
        AnimatablePairView()
    }
}
