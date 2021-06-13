//
//  StashChallengeEntityTests.swift
//  StashChallengeTests
//
//  Created by Ace Green on 6/13/21.
//

import XCTest
import AGViperKit
@testable import StashChallenge

class StashChallengeEntityTests: XCTestCase {

    func testAchievementEntity() throws {

        let expectation = self.expectation(description: "expectation")

        let imageString = "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/C850B103-B8C5-4518-8631-168BB42FFBBD.png"
        let mockAchievement = Achievement(id: 4,
                                          level: "1",
                                          progress: 10,
                                          total: 50,
                                          imageURL: imageString,
                                          accessible: true)

        XCTAssertEqual(mockAchievement.id, 4)
        XCTAssertEqual(mockAchievement.level, "1")
        XCTAssertEqual(mockAchievement.progress, 10)
        XCTAssertEqual(mockAchievement.total, 50)
        XCTAssertEqual(mockAchievement.imageURL, imageString)
        XCTAssertTrue(mockAchievement.accessible == true)

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }
}
