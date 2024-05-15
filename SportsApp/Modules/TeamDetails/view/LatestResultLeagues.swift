//
//  LatestResultLeagues.swift
//  SportsApp
//
//  Created by Israa on 11/05/2024.
//

import Foundation

struct LatestResultLeagues: Decodable {
    let success: Int
    let result: [LatestResult]?
}
struct LatestResult: Decodable {
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    let eventDate: String?
    let eventTime: String?
    let leagueRound: String?
    let leagueSeason: String?
    let eventFinalResult: String?
    // Tennis
    let eventFirstPlayer: String?
    let eventSecondPlayer: String?
    let eventFirstPlayerLogo: String?
    let eventSecondPlayerLogo: String?
    // Basketball and Cricket
    let eventHomeTeamLogo: String?
    let eventAwayTeamLogo: String?
    // Cricket
    let eventHomeFinalResult: String?
    
    enum CodingKeys: String, CodingKey {
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventHomeTeam = "event_home_team"
        case eventAwayTeam = "event_away_team"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventFinalResult = "event_final_result"
        case eventFirstPlayer = "event_first_player"
        case eventSecondPlayer = "event_second_player"
        case eventFirstPlayerLogo = "event_first_player_logo"
        case eventSecondPlayerLogo = "event_second_player_logo"
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
        case eventHomeFinalResult = "event_home_final_result"
    }
}
