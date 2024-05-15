//
//  TeamDetails.swift
//  SportsApp
//
//  Created by Israa on 11/05/2024.
//

import Foundation

class TeamDetails: Decodable {
    let success: Int?
    let result: [TeamDetailsResult]?
}

struct TeamDetailsResult: Decodable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    let players: [Player]?
    let coaches: [Coach]?

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
        case coaches
    }
}

struct Player: Decodable {
    let playerAge: String?
    let playerImage: String?
    let playerName: String?
    let playerNumber: String?
    let playerType: String?
    let playerMatchPlayed: String?
    let playerGoals: String?
    let playerYellowCards: String?
    let playerRedCards: String?

    enum CodingKeys: String, CodingKey {
        case playerAge = "player_age"
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerType = "player_type"
        case playerMatchPlayed = "player_match_played"
        case playerGoals = "player_goals"
        case playerYellowCards = "player_yellow_cards"
        case playerRedCards = "player_red_cards"
    }
}

struct Coach: Decodable {
    let coachName: String?

    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
    }
}
