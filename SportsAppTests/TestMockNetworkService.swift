//
//  YestMockNetworkService.swift
//  SportsAppTests
//
//  Created by Apple on 15/05/2024.
//

import XCTest
@testable import SportsApp

final class TestMockNetworkService: XCTestCase {
    var mockObj : MockNetworkService!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockObj = MockNetworkService(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMockData() {
        mockObj.fetchLeagueData {  (result: Result<APIResponse<League>, Error>)  in
            switch result {
            case .success(let leagues):
                XCTAssertNotNil(leagues)
                XCTAssertEqual(leagues.success, 1)
                XCTAssertEqual(leagues.result?[0].leagueName, "UEFA Europa League")
                XCTAssertEqual(leagues.result?[0].leagueKey, 4)
            case .failure(let error):
                print("Error fetching teams: \(error)")
                XCTFail()
            }
        }
    }
    

}
