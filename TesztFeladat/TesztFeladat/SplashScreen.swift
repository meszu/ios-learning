//
//  SplashScreen.swift
//  TesztFeladat
//
//  Created by Mészáros Kristóf on 2022. 01. 18..
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        
        let color = LinearGradient(colors: [.purple,.orange], startPoint: .leading, endPoint: .trailing)
        
        ZStack {
            ZStack {
                Text("Üdvözli a Lecsút FC")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(20)
                Spacer()
            }
            .background(color)
            .edgesIgnoringSafeArea(.all)
            .cornerRadius(20)
            .shadow(color: Color(.gray), radius: 10, x: 0, y: 0)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color(.white))
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
