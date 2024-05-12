//
//  League.swift
//  SportsApp
//
//  Created by Apple on 12/05/2024.
//

import Foundation

class League : Decodable {
    var leagueKey : Int?
    var leagueName : String?
    var leagueLogo : String?
    
    enum CodingKeys : String , CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
    }
}
