//
//  NetworkServiceTest.swift
//  SportsAppTests
//
//  Created by Apple on 16/05/2024.
//

import XCTest
@testable import SportsApp
final class NetworkServiceTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchData() {
        // Given
        let networkService = NetworkService.instance
        let endPoint = "/football/"
        let expectation = XCTestExpectation(description: "Fetch data expectation")
        
        // When
        networkService.fetchData(from: endPoint, parameters: ["met":"Leagues"]) { (result: Result<League, Error>) in
            // Then
            switch result {
            case .success(let response):
                
                XCTAssertNotNil(response, "Response should not be nil")
                expectation.fulfill()
                
            case .failure(let error):
                
                XCTFail("Error occurred: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func testFetchDataFailure() {
        // Given
        let networkService = NetworkService.instance
        let endPoint = "/nonexistent/"
        let expectation = XCTestExpectation(description: "Fetch data failure expectation")
        
        // When
        networkService.fetchData(from: endPoint, parameters: nil) { (result: Result<League, Error>) in
            // Then
            switch result {
            case .success(let response):
                XCTFail("Test case passed unexpectedly. Response: \(response)")
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
}
