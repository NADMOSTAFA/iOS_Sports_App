//
//  LeagueTeams.swift
//  SportsApp
//
//  Created by Israa on 11/05/2024.
//

import Foundation

struct LeagueTeams: Decodable {
    let success: Int
    let result: [Team]?
}

struct Team: Decodable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
    }
}

