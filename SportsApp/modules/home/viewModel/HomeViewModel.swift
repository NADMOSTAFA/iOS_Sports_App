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
}

class HomeViewModel : HomeViewModelProtocol{
    let sports : [Sport] = [
        Sport(name: "Football", image: "football2"),
        Sport(name: "Basketball", image: "basket1"),
        Sport(name: "Tennis", image: "tennis1"),
        Sport(name: "Cricket", image:  "cricket1")
    ]
    
    func getSportsCount() -> Int {
        return sports.count
    }
    
    func getSports() -> [Sport] {
        return sports
    }
}
