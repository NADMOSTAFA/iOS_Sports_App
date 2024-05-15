//
//  TeamDetailsViewModel.swift
//  SportsApp
//
//  Created by Israa on 15/05/2024.
//

import Foundation


class TeamDetailsViewModel {
    
    var network : NetworkServiceProtocol?
    
    var  teamId:Int?
    
    var bindTeamData :  (() -> Void) = {}
    
    var teamData : TeamDetailsResult?
    
    init(network: NetworkServiceProtocol? = nil, teamId: Int? = nil) {
        self.network = network
        self.teamId = teamId
    }
    
    func loadTeamData(){
        
        guard let teamId = teamId else {return}
        network?.fetchData(from: "/?met=Teams", parameters: ["teamId" : teamId], completion: {
            (result: Result<APIResponse<TeamDetails>, Error>) in
            
            
            switch result {
            case .success(let teamDetails):
                print ("\(MyDateFormatter.getDateToPreviousOneYearFromNow())")
                self.teamData =   teamDetails.result?.first as? TeamDetailsResult
                self.bindTeamData()
            case .failure(let error):
                print("Error fetching latestResults: \(error)")
            }
        })
        
        
        
    }
    
    func getPlayersCount() ->Int {
        
        return teamData?.players?.count ?? 0
    }
    
    func getPlayerAtIndex(index:Int) -> Player {
        
        return (teamData?.players?[index])!
    }
    
    func getCocachesCount() ->Int {
        
        return teamData?.coaches?.count ?? 0
    }
    
    func getCoachAtIndex(index:Int) -> Coach {
        
        return (teamData?.coaches?[index] )!
    }
    
}
