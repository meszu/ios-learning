//
//  MatchesModel.swift
//  TesztFeladat
//
//  Created by Mészáros Kristóf on 2022. 01. 12..
//

import Foundation

struct MatchesModel: Decodable, Identifiable {
    var id: String {
        return String(gameId)
    }
    let gameId: Int
    let sportType: String
    let serieName: String
    let turnNumber: Int
    let homeTeam: String
    let homeImage: String
    let guestImage: String
    let guestTeam: String
    let homeTeamResult: String
    let guestTeamResult: String
    let dateOfGame: String
    let cityOfGame: String
    let addressOfGame: String
    let numberOfAddress: String
    
    var dateToDisplay: String {
        var resultString: String
        //Convert String to Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.date(from: String(dateOfGame.prefix(10)))
        //Convert Date to Day Of Week String
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek  = dateFormatter.string(from: dateString!)
        
        if String(dateOfGame.suffix(7)) == "0:00:00" {
            let displayedDate = String(dateOfGame.subString(from: 0, to: 4)) + "." + String(dateOfGame.subString(from: 5, to: 7)) + "." + String(dateOfGame.subString(from: 8, to: 10)) + "." + " \(dayOfWeek.uppercased())"
                                                                                                                                               
            resultString = displayedDate
        } else {
            let dateWithHour = String(dateOfGame.subString(from: 0, to: 4)) + "." + String(dateOfGame.subString(from: 5, to: 7)) + "." + String(dateOfGame.subString(from: 8, to: 10)) + "." + " \(dayOfWeek.uppercased())"
            resultString = dateWithHour
        }
        
        return resultString
    }
    
    var hourToDisplay: String {
        var resultString: String
        
        if String(dateOfGame.suffix(7)) == "0:00:00" {
            resultString = " "
        } else {
            let gameHour = String(dateOfGame.subString(from: 11, to: 16))
            resultString = gameHour
        }
        
        return resultString
    }
    
    var placeToDisplay: String {
        if addressOfGame != "" {
            return "\(cityOfGame), \(addressOfGame)"
        } else {
            return "\(cityOfGame)"
        }
    }
    
    var turnToDisplay: String {
        return "\(turnNumber). FORDULÓ"
    }
    
}
