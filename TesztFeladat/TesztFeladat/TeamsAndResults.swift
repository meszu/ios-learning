//
//  TeamsAndResults.swift
//  TesztFeladat
//
//  Created by Mészáros Kristóf on 2022. 07. 18..
//

import Foundation
import SwiftUI

struct TeamsAndResultView: View {
    let game: MatchesModel
    let proxy: GeometryProxy
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                AsyncImage(url: URL(string: "\(game.homeImage)")) { image in
                    image.resizable()
             //           .fitToAspectRatio(280/240)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: proxy.size.width, height: proxy.size.height / 8)
                        .frame(width: proxy.size.height * 280 / 240)
                        .clipped()
                } placeholder: {
                    Image("placeholder1x1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width, height: proxy.size.height / 8)
                        .frame(width: proxy.size.height * 280 / 240)
                        .clipped()
                }
                
                Text(game.homeTeam)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(width: proxy.size.width / 2.8)
            .padding(.leading, proxy.size.width / 25)
            
            Spacer()
            
            Text("\(game.homeTeamResult) - \(game.guestTeamResult)")
                .font(.title)
                .bold()
                .kerning(-2)
                .lineLimit(1)
                .offset(x: 0, y: 40)

            Spacer()
            
            VStack {
                
                AsyncImage(url: URL(string: "\(game.guestImage)")) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width, height: proxy.size.height / 8)
                        .frame(width: proxy.size.height * 280 / 240)
                        .clipped()
                } placeholder: {
                    Image("placeholder1x1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width, height: proxy.size.height / 8)
                        .frame(width: proxy.size.height * 280 / 240)
                        .clipped()
                }
                
                Text(game.guestTeam)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(width: proxy.size.width / 2.8)
            .padding(.trailing, proxy.size.width / 25)
        }
        .frame(height: proxy.size.height / 3.7)
    }
}
