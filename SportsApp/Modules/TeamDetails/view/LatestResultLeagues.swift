//
//  LatestResultLeagues.swift
//  SportsApp
//
//  Created by Israa on 11/05/2024.
//

import Foundation

struct LatestResultLeagues: Codable {
    let success: Int
    let result: [LatestResult]?
}
struct LatestResult:Codable {
    let home_team_logo:String?
    let away_team_logo:String?
    let event_home_team:String?
    let event_away_team:String?
    let event_date:String?
    let event_time:String?
    let league_round:String?
    let league_season:String?
    let event_final_result:String?
    // Tennis
    let event_first_player:String?
    let event_second_player:String?
    let event_first_player_logo:String?
    let event_second_player_logo:String?
    // Basketball and Cricket
     let event_home_team_logo:String?
     let event_away_team_logo:String?
    // Cracket
    let event_home_final_result:String?
}
