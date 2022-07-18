//
//  HeadView.swift
//  TesztFeladat
//
//  Created by Mészáros Kristóf on 2022. 07. 18..
//

import SwiftUI

struct HeadlineView: View {
    let game: MatchesModel
    let proxy: GeometryProxy
    
    var body: some View {

    HStack {
        Text(game.sportType.uppercased())
            .font(.body)
            .fontWeight(.regular)
            .padding([.top, .bottom], 20)
            .frame(minWidth: proxy.size.width / 3)

        Spacer()
        VStack(alignment: .trailing) {
            Text(game.serieName)
                .font(.subheadline)
                .fontWeight(.heavy)
                .multilineTextAlignment(.trailing)
                .lineLimit(2)
                .layoutPriority(1)
            Text(game.turnToDisplay)
                .font(.subheadline)
                .fontWeight(.light)
        }
        .layoutPriority(0.5)
    }
    .padding([.trailing, .leading],20)
    .aspectRatio(1080/166, contentMode: .fit)
    .frame(width: proxy.size.width)
  //  .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 15)
    .background(Color(red: 0.88, green: 0.88, blue: 0.88))

    }
}

