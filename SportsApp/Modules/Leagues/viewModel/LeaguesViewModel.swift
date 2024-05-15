//
//  LeaguesViewModel.swift
//  SportsApp
//
//  Created by Apple on 12/05/2024.
//

import Foundation



protocol LeaguesViewModelProtocol{
    func loadData(endPoint : String)
    func getLeaguesCount() -> Int
    func getLeagues() -> [League]
    func getselectedLeague() -> League
    func setselectedLeague(league : League)
    
    func getEndPoint() -> String
    func setEndPoint(endPoint : String)
}

class LeaguesViewModel:LeaguesViewModelProtocol{
        
    var network : NetworkServiceProtocol
    var bindLeaguesToViewConreoller : (() -> ())={}
    var leagues : [League]?
    var  selectedLeague : League?
    var endPoint : String?
    
    init(network: NetworkServiceProtocol) {
        self.network = network
    }
    
    func loadData(endPoint : String ){
        network.fetchData(from: endPoint, parameters: ["met":"Leagues"]){
            (result: Result<APIResponse<League>, Error>) in
           switch result {
            case .success(let leagues):
                self.leagues = leagues.result!
               self.bindLeaguesToViewConreoller()
                print("Teams fetched successfully: \(String(describing: self.leagues!.count))")
            case .failure(let error):
                print("Error fetching teams: \(error)")
            }
        }
    }

    func getLeaguesCount() -> Int {
        return leagues?.count ?? 0
    }
    
    func getLeagues() -> [League] {
        return leagues ?? []
    }
    
    func getselectedLeague() -> League {
        return selectedLeague ??  League()
    }
    
    func setselectedLeague(league : League) {
        selectedLeague = league
    }
    
    func getEndPoint() -> String {
        return endPoint ?? ""
    }
    
    func setEndPoint(endPoint: String) {
        self.endPoint = endPoint
    }
}
