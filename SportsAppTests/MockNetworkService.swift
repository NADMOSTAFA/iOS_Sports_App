//
//  MockNetworkService.swift
//  SportsAppTests
//
//  Created by Apple on 15/05/2024.
//
import Foundation
@testable import SportsApp

class MockNetworkService {
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let leagueFakeObj: [String: Any] = [
        "success": 1,
        "result": [
            [
                "league_key": 4,
                "league_name": "UEFA Europa League",
                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/"
            ]
        ]
    ]
}

extension MockNetworkService {
    enum responseWithError: Error{
        case error
    }
    func fetchLeagueData<T: Decodable>(completionHandler: @escaping ((Result<T, Error>)) -> Void) {
        var result : T?
        do {
            let data = try JSONSerialization.data(withJSONObject: leagueFakeObj)
            result = try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            print(error.localizedDescription)
        }
        if shouldReturnError {
            completionHandler(.failure(responseWithError.error))
        } else {
            completionHandler(.success(result!))
        }
    }
}
