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
        leagues = db.getAllLeagues()
        guard let leagues = leagues else {return}
        bindLeaguesToViewController()
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
