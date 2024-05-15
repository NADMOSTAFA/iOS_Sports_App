//
//  UpCommingLeagues.swift
//  SportsApp
//
//  Created by Israa on 11/05/2024.
//

struct UpCommingLeagues: Decodable {
    let success: Int
    let result: [Upcoming]?
    
    enum CodingKeys: String, CodingKey {
        case success
        case result
    }
}

struct Upcoming: Decodable {
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    let eventDate: String?
    let eventTime: String?
    let leagueRound: String?
    let leagueSeason: String?
    var home_team_key :Int?
    var away_team_key : Int?
    
    var eventFinalResult:String?
       // Cracket
    var eventHomeFinalResult:String?
    
    // Tennis
    let eventFirstPlayer: String?
    let eventSecondPlayer: String?
    let eventFirstPlayerLogo: String?
    let eventSecondPlayerLogo: String?
    var first_player_key: Int?
    var second_player_key :Int?
    // Basketball and Crikcet
    let eventHomeTeamLogo: String?
    let eventAwayTeamLogo: String?
    // Cricket
    let eventDateStart: String?
    
    enum CodingKeys: String, CodingKey {
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventHomeTeam = "event_home_team"
        case eventAwayTeam = "event_away_team"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventFirstPlayer = "event_first_player"
        case eventSecondPlayer = "event_second_player"
        case eventFirstPlayerLogo = "event_first_player_logo"
        case eventSecondPlayerLogo = "event_second_player_logo"
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
        case eventDateStart = "event_date_start"
        case home_team_key = "home_team_key"
        case away_team_key = "away_team_key"
        case first_player_key = "first_player_key"
        case second_player_key = "second_player_key"
        case eventFinalResult = "event_final_result"
        case eventHomeFinalResult = "event_home_final_result"
        
    }
}

