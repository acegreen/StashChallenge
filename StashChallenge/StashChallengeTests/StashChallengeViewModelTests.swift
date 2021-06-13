//
//  StashChallengeViewModelTests.swift
//  StashChallengeTests
//
//  Created by Ace Green on 6/13/21.
//

import XCTest
import AGViperKit
@testable import StashChallenge

class StashChallengeViewModelTests: XCTestCase {

    func testMockViewModel() throws {

        let expectation = self.expectation(description: "expectation")

        let imageURL = URL(string: "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/C850B103-B8C5-4518-8631-168BB42FFBBD.png")
        let mockAchievement = AchievementViewModel(level: "1",
                                                   progress: 0.1,
                                                   minLabel: "10pts",
                                                   maxLabel: "50pts",
                                                   imageURL: imageURL,
                                                   accessible: true)

        XCTAssertEqual(mockAchievement.level, "1")
        XCTAssertEqual(mockAchievement.progress, 0.1)
        XCTAssertEqual(mockAchievement.minLabel, "10pts")
        XCTAssertEqual(mockAchievement.maxLabel, "50pts")
        XCTAssertEqual(mockAchievement.imageURL, imageURL)
        XCTAssertTrue(mockAchievement.accessible == true)

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }
}
