//
//  AspectRatioModify.swift
//  TesztFeladat
//
//  Created by Mészáros Kristóf on 2022. 01. 18..
//

import SwiftUI

public struct FitToAspectRatio: ViewModifier {
    
    private let aspectRatio: CGFloat
    
    public init(_ aspectRatio: CGFloat) {
        self.aspectRatio = aspectRatio
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .aspectRatio(aspectRatio, contentMode: .fit)
            
            content
                .scaledToFit()
                .layoutPriority(-1)
        }
        .clipped()
    }
}

public extension Image {
    func fitToAspectRatio(_ aspectRatio: CGFloat) -> some View {
        self.resizable().modifier(FitToAspectRatio(aspectRatio))
    }
    
}
