//
//  DateAndPlaceView.swift
//  TesztFeladat
//
//  Created by Mészáros Kristóf on 2022. 07. 18..
//

import SwiftUI

struct DateAndPlaceView: View {
    let game: MatchesModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(
                    game.dateToDisplay
                )
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                Text(game.placeToDisplay)
                    .font(.system(size: 15))
                    .fontWeight(.light)
                    .lineLimit(2)
            }
            .padding(.leading, 10)
            Spacer()
            Text(game.hourToDisplay)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.trailing)
                .padding(10)
        }
        .background(.white.opacity(0.5))
        .padding(.bottom, 13)
    }
}

