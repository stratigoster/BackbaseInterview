//
//  BackbaseTests.swift
//  BackbaseTests
//
//  Created by William  on 2018-11-19.
//  Copyright © 2018 William . All rights reserved.
//

import XCTest
@testable import Backbase

class BackbaseTests: XCTestCase {
    var systemUnderTest: ViewController!
    override func setUp() {
        super.setUp()
        systemUnderTest = ViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testSUT_HasSearchBar() {
        
        XCTAssertNotNil(systemUnderTest.searchBar)
    }
    
    // MARK: - Search Auto-Suggest Behavior
    
    func testSUT_CanProperlyDisplay_CityState_AutoSuggestionsInTableView_AfterSearchTextChanges() {
        
        // sample of searchable items (instead of fetching asynchronously from network)
        let firstLocation = Location(_id: 1, coord: Location.Coor(lat: 123.2, lon: 23.2), country: "US", name: "Alabama")
        let secondLocation = Location(_id: 2, coord: Location.Coor(lat: 123.2, lon: 23.2), country: "US", name: "Albuquerque")
        let thirdLocation = Location(_id: 3, coord: Location.Coor(lat: 123.2, lon: 23.2), country: "US", name: "Anaheim")
        let fourthLocation = Location(_id: 4, coord: Location.Coor(lat: 123.2, lon: 23.2), country: "US", name: "Arizona")
        let fifthLocation = Location(_id: 5, coord: Location.Coor(lat: 123.2, lon: 23.2), country: "AU", name: "Sydney")
        
        systemUnderTest.model = [firstLocation, secondLocation, thirdLocation, fourthLocation, fifthLocation]
        
        // simulate user typing in Search text and confirm results
        systemUnderTest.searchBar(systemUnderTest.searchBar, textDidChange: "A")
        XCTAssertEqual(systemUnderTest.filteredTableData.count, 4)
        XCTAssertEqual(systemUnderTest.filteredTableData[0].name, "Alabama")
        XCTAssertEqual(systemUnderTest.filteredTableData[1].name, "Albuquerque")
        XCTAssertEqual(systemUnderTest.filteredTableData[2].name, "Anaheim")
        XCTAssertEqual(systemUnderTest.filteredTableData[3].name, "Arizona")
        
        
        systemUnderTest.searchBar(systemUnderTest.searchBar, textDidChange: "Al")
        XCTAssertEqual(systemUnderTest.filteredTableData.count, 2)
        XCTAssertEqual(systemUnderTest.filteredTableData[0].name, "Alabama")
        XCTAssertEqual(systemUnderTest.filteredTableData[1].name, "Albuquerque")
        
        systemUnderTest.searchBar(systemUnderTest.searchBar, textDidChange: "Alb")
        XCTAssertEqual(systemUnderTest.filteredTableData.count, 1)
        XCTAssertEqual(systemUnderTest.filteredTableData[0].name, "Albuquerque")
        
    }
    
    
    func testSUT_CanProperlyDisplay_ZipCode_AutoSuggestionsInTableView_AfterSearchTextChanges() {
        
        // sample of searchable items (instead of fetching asynchronously from network)
        let firstLocation = Location(_id: 1, coord: Location.Coor(lat: 123.2, lon: 23.2), country: "US", name: "Alabama")
        let secondLocation = Location(_id: 2, coord: Location.Coor(lat: 123.2, lon: 23.2), country: "US", name: "Albuquerque")
        let thirdLocation = Location(_id: 3, coord: Location.Coor(lat: 123.2, lon: 23.2), country: "US", name: "Anaheim")
        let fourthLocation = Location(_id: 4, coord: Location.Coor(lat: 123.2, lon: 23.2), country: "US", name: "Arizona")
        let fifthLocation = Location(_id: 5, coord: Location.Coor(lat: 123.2, lon: 23.2), country: "AU", name: "Sydney")
        
        systemUnderTest.model = [firstLocation, secondLocation, thirdLocation, fourthLocation, fifthLocation]
        
        // simulate user typing in Search text and confirm results
        systemUnderTest.searchBar(systemUnderTest.searchBar, textDidChange: "z")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
