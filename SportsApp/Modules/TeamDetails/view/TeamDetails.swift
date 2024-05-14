//
//  TeamDetails.swift
//  SportsApp
//
//  Created by Israa on 11/05/2024.
//

import Foundation

struct TeamDetails: Codable {
    let success: Int?
    let result: [TeamDetailsResult]?
}

struct TeamDetailsResult :Codable {
    let team_key:Int?
    let team_name:String?
    let team_logo:String?
    let players:[Player]?
    let coaches:[Coach]?
}

struct Player:Codable {
    let player_age:String?
    let player_image:String?
    let player_name:String?
    let player_number:String?
    let player_type:String?
    let player_match_played:String?
    let player_goals:String?
    let player_yellow_cards:String?
    let player_red_cards:String?
}
struct Coach:Codable{
    let coach_name:String?
}
