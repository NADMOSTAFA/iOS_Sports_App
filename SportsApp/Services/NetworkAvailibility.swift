//
//  NetworkAvailibility.swift
//  SportsApp
//
//  Created by Apple on 15/05/2024.
//

import Foundation
import Reachability

class NetworkAvailibility{
    
    static func isConnected () -> Bool{
        let reachability = try! Reachability()
        switch reachability.connection {
        case .unavailable:
            return false
        case .wifi:
            return true
        case .cellular:
            return true
        }
    }
    
}
