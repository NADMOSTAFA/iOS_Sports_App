//
//  LeagueDetailsViewModel.swift
//  SportsApp
//
//  Created by Israa on 12/05/2024.
//

import Foundation
protocol LeagueDetailsViewModelProtocol{
    
    func loadUpcomingFixture(endPoint : String, leagueID : Int)
    func loadLatestResults(endPoint : String, leagueID : Int)
    
    func getUpcomingFixturesCount() -> Int
    func  getLatestResultsCount() -> Int
    
    func getUpcomingFixtures() -> [Upcoming]
    func getLatestResults() -> [Upcoming]
    
    func getselectedTeam() -> Team
    func setselectedTeam(team : Team)
}

class LeagueDetailsViewModel : LeagueDetailsViewModelProtocol {
    
    var network : NetworkServiceProtocol
    var bindUpcomingFixtureToViewConreoller : (() -> ())={}
    var bindLatestResultsToViewConreoller : (() -> ())={}
    
    var teams : [Team]?
    var upComingFixtures : [Upcoming]?
    var latestResults : [Upcoming]?
    
    var  selectedTeam : Team?
    
    
    init(network: NetworkServiceProtocol) {
        self.network = network
    }
    
    func loadUpcomingFixture(endPoint: String, leagueID: Int) {
        network.fetchData(from: endPoint, parameters: ["met":"Fixtures", "leagueId" : leagueID, "from":  MyDateFormatter.getCurrentDate() , "to" : MyDateFormatter.getDateToUpcommingOneYearFromNow()]){
            (result: Result<APIResponse<Upcoming>, Error>) in
           switch result {
            case .success(let upComingFixtures):
               print ("\(MyDateFormatter.getDateToUpcommingOneYearFromNow())")
                self.upComingFixtures = upComingFixtures.result ?? []
               self.bindUpcomingFixtureToViewConreoller()
               print("UpComing fetched successfully: \(String(describing: self.upComingFixtures!.count))")
            case .failure(let error):
                print("Error fetching UpComing: \(error)")
            }
        }
    }
    
    func loadLatestResults(endPoint: String, leagueID: Int) {
        
            network.fetchData(from: endPoint, parameters: ["met":"Fixtures", "leagueId" : leagueID, "from":  MyDateFormatter.getDateToPreviousOneYearFromNow() , "to" : MyDateFormatter.getCurrentDate()]){
                (result: Result<APIResponse<Upcoming>, Error>) in
               switch result {
                case .success(let latestResults):
                   print ("\(MyDateFormatter.getDateToPreviousOneYearFromNow())")
                    self.latestResults = latestResults.result ?? []
                   self.bindLatestResultsToViewConreoller()
                   print("latestResults fetched successfully: \(String(describing: self.latestResults!.count))")
                case .failure(let error):
                    print("Error fetching latestResults: \(error)")
                }
            }   
    }
    

    func getUpcomingFixturesCount() -> Int {
        return upComingFixtures?.count ?? 0
    }
    
    func getLatestResultsCount() -> Int {
        return latestResults?.count ?? 0
    }
 
    
    func getUpcomingFixtures() -> [Upcoming] {
        return upComingFixtures ?? []
    }
    
    func getLatestResults() -> [Upcoming] {
        return latestResults ?? []
    }
    
    func getselectedTeam() -> Team {
        return selectedTeam ?? Team(teamKey: 0, teamName: nil, teamLogo: nil)
    }
    
    func setselectedTeam(team: Team) {
        selectedTeam = team
    }

}


