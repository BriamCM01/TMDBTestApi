//
//  HomeMoviewTests.swift
//  MyMoviesDTests
//
//  Created by Briam Cano on 05/08/24.
//

import XCTest
@testable import MyMoviesD

final class HomeMoviewTests: XCTestCase {

    var sut: HomeMoviesViewController!
    
    override func setUpWithError() throws {
        sut = HomeMoviesViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
       sut = nil
    }

    func testExample() throws {
        let tableView = try XCTUnwrap(sut.tableViewTopRateMovies, "Should be create IBOutlet to tableView")
        let titleLabel = "MDB MOVIES API"
        let upcomingTitle = "Proximos estrenos"
        let topRateTitle = "Recomendaciónes"
        
        XCTAssertEqual(titleLabel, sut.lblTitleView.text, "-")
        XCTAssertEqual(upcomingTitle, sut.lblUpcoming.text, "-")
        XCTAssertEqual(topRateTitle, sut.lblTopRate.text, "-")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
