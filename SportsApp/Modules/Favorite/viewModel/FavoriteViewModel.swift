//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by Apple on 14/05/2024.
//

import Foundation

class FavoriteViewModel :  LeaguesViewModelProtocol{

    
    let db = DBManager.instance
    var bindLeaguesToViewController : (() -> ())={}
    var leagues : [League]?
    var selectedLeague : League?
    var endPoint : String?
    
    func loadData(endPoint: String) {
        DispatchQueue.global().async {
            self.leagues = self.db.getAllLeagues()
            guard let _ = self.leagues else {return}
            self.bindLeaguesToViewController()
        }
    }
    
    func deleteStroedLeague(league:League ,index:Int){
        leagues?.remove(at: index)
        db.deleteLeague(league: league)
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
