//
//  MatchData.swift
//  TesztFeladat
//
//  Created by Mészáros Kristóf on 2022. 01. 12..
//

import Foundation

struct Root: Decodable {
    let data: [Match]
}

struct Match: Decodable, Identifiable {
    var id: String {
        return String(game.gameId)
    }
    var game: Game
    let homTeam: HomTeam
    let guestTeam: GuestTeam
    let serie: Serie
    let palce: Palce

    enum CodingKeys: String, CodingKey {
        case game = "game"
        case homTeam = "homTeam"
        case guestTeam = "guestTeam"
        case serie = "serie"
        case palce = "palce"
    }
}

struct Game: Decodable {
    let gameId: Int
    let placeId: Int
    let homeId: Int
    let start: String
    let sport: String
    let turn: Int
    let resultHome: String
    let resultGuest: String
}

struct HomTeam: Decodable {
    let crest: String
    let name: String
}

struct GuestTeam: Decodable {
    let name: String
    let crest: String
}

struct Serie: Decodable {
    let name: String
}

struct Palce: Decodable {
    let address: String
    let city: String
    let number: String
}
