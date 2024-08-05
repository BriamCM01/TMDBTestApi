//
//  MyMoviesDTests.swift
//  MyMoviesDTests
//
//  Created by Briam Cano on 02/08/24.
//

import XCTest
@testable import MyMoviesD

final class UserInfoFormTests: XCTestCase {

    var sut: UserInfoFormViewController!
    
    override func setUpWithError() throws {
        let nib = UserInfoFormViewController(nibName: "UserInfoFormViewController", bundle: .main)
        sut = nib
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testUserInfo_ValidateTextField_areEmpty() throws {
        let userName = try XCTUnwrap(sut.txtuserName)
        let favoriteMovie = try XCTUnwrap(sut.txtFavoriteMovie)
        
        XCTAssertEqual(userName.text, "", "The userName Textfield should be empty")
        XCTAssertEqual(favoriteMovie.text, "", "The favoriteMovie Textfield should be empty")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
