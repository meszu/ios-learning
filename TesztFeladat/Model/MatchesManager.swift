//
//  MatchStore.swift
//  TesztFeladat
//
//  Created by Mészáros Kristóf on 2022. 01. 11..
//

import Foundation
import Combine
import UIKit




class MatchesManager: ObservableObject {
    
    @Published var games = [Match]()
    @Published var matchList = [MatchesModel]()
    
    private let matchesURL = "https://run.mocky.io/v3/9e2ad247-8c40-453e-838b-5188042e9810"
    
    
    func fetchMatches() {
        performRequest(urlString: matchesURL)
    }
    
    func performRequest(urlString: String) {
        //1 create url
        if let url = URL(string: urlString) {
            //2 create a urlsession
            let session = URLSession(configuration: .default)
            //3 give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(Root.self, from: safeData)
                        
                        DispatchQueue.main.async {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            
                            //Check for valid starting date
                            
                                for game in decodedData.data {
                                    
                                    let matchStartingDate = String(game.game.start.prefix(10))
                                    
                                    if  dateFormatter.date(from: matchStartingDate) != nil {
                                        
                                        let gameId = game.game.gameId
                                        let sportType = game.game.sport
                                        let serieName = game.serie.name
                                        let turnNumber = game.game.turn
                                        let homeTeam = game.homTeam.name
                                        let homeImage = game.homTeam.crest
                                        let guestTeam = game.guestTeam.name
                                        let guestImage = game.guestTeam.crest
                                        let homeTeamResult = game.game.resultHome
                                        let guestTeamResult = game.game.resultGuest
                                        let dateOfGame = game.game.start
                                        let cityOfGame = game.palce.city
                                        let addressOfGame = game.palce.address
                                        let numberOfAddress = game.palce.number
                                        // game == decodedData.data[0]
                                        let currentMatch = MatchesModel(gameId: gameId, sportType: sportType, serieName: serieName, turnNumber: turnNumber, homeTeam: homeTeam, homeImage: homeImage, guestImage: guestImage, guestTeam: guestTeam, homeTeamResult: homeTeamResult, guestTeamResult: guestTeamResult, dateOfGame: dateOfGame, cityOfGame: cityOfGame, addressOfGame: addressOfGame, numberOfAddress: numberOfAddress)
                                        
                                        self.matchList.append(currentMatch)
                                        self.matchList.sort { $0.dateOfGame > $1.dateOfGame }
                                    } else {
                                        continue
                                    }
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            //4 start the task
            task.resume()
        }
    }
}
    


