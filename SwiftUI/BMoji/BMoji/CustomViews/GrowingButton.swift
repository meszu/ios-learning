//
//  GrowingButton.swift
//  BMoji
//
//  Created by Mészáros Kristóf on 2022. 11. 13..
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(.black)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1 : 0.8)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
