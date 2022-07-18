//
//  ContentView.swift
//  TesztFeladat
//
//  Created by Mészáros Kristóf on 2022. 01. 11..
//

import SwiftUI

struct ContentView: View {
    let headerColor = Color(red: 0.9, green: 0.9, blue: 0.9)
    @State private var text = ""
    @State var showSplash = true
        
    @ObservedObject var matchesManager = MatchesManager()
    
    var body: some View {
        
        //Filter for making the search text case and diacritical insensitive
        let predicate = NSPredicate(format: "SELF CONTAINS[cd] %@", text)

        GeometryReader { proxy in
            ZStack {
                NavigationView {
                    ScrollView {
                        ForEach(text == "" ? matchesManager.matchList: matchesManager.matchList.filter { predicate.evaluate(with: $0.guestTeam) || predicate.evaluate(with: $0.cityOfGame) || predicate.evaluate(with: $0.homeTeam) } ) { game in
                            VStack {
                                VStack {
                                    HeadlineView(game: game, proxy: proxy)
                                        ZStack(alignment: .bottom) {
                                            TeamsAndResultView(game: game, proxy: proxy)
                                                .padding(.bottom, proxy.size.height / 13)
                                                .padding(.top, -1 * (proxy.size.height / 26))
                                            DateAndPlaceView(game: game)
                                            }
                                        }
                                    .background(Image("teamCellBackgroundImage").resizable()
                                                    .shadow(color: .gray, radius: 10)
                                                    .aspectRatio(1080/760 ,contentMode: .fill)
                                )
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: proxy.size.width, height: proxy.size.height / 120)
                            }
                        }
                        .onAppear(
                            perform: matchesManager.fetchMatches
                        )
                        .searchable(text: $text)
                        .navigationTitle("Mérkőzések")
                    }


                }
                SplashScreen()
                    .opacity(showSplash ? 1 : 0)
                    .onAppear {
                         DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                           withAnimation() {
                             self.showSplash = false
                           }
                         }
                    }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
      


