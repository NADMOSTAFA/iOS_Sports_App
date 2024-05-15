//
//  HomeViewModel.swift
//  SportsApp
//
//  Created by Nada Mostafa on 10/05/2024.
//

import Foundation

protocol HomeViewModelProtocol {
    func getSportsCount() -> Int
    func getSports() -> [Sport]
    func getSportType() -> String?
    func setSportType(type : String)
}

class HomeViewModel : HomeViewModelProtocol{
    let sports : [Sport] = [
        Sport(name: "Football", image: "football2"),
        Sport(name: "Basketball", image: "basket1"),
        Sport(name: "Tennis", image: "tennis1"),
        Sport(name: "Cricket", image:  "cricket1")
    ]
    var sportType : String?
    
    func getSportsCount() -> Int {
        return sports.count
    }
    
    func getSports() -> [Sport] {
        return sports
    }
    
    func setSportType(type : String){
        sportType = type
    }
    func getSportType() -> String? {
        return sportType
    }
}
