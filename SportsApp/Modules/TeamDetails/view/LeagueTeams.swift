//
//  LeagueTeams.swift
//  SportsApp
//
//  Created by Israa on 11/05/2024.
//

import Foundation

struct LeagueTeams: Codable {
    let success: Int
    let result: [Team]?
}

struct Team: Codable {
    let team_key: Int
    let team_name: String?
    let team_logo: String?
}
