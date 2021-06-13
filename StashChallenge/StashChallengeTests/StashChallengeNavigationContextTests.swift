//
//  StashChallengeNavigationContextTests.swift
//  StashChallengeTests
//
//  Created by Ace Green on 6/13/21.
//

import XCTest
import AGViperKit
@testable import StashChallenge

class StashChallengeNavigationContextTests: XCTestCase {

    let navigationContext = AchievementsNavigationContext.main

    func testAchievementsNavigationContext() throws {

        let expectation = self.expectation(description: "expectation")

        let presenter = AchievementsPresenter.shared
        let interactor = AchievementsInteractor.shared
        let achievementsTableViewController = UIStoryboard.achievements.controller(class: AchievementsTableViewController.self)

        XCTAssertTrue(type(of: navigationContext.presenter) == type(of: presenter))
        XCTAssertTrue(type(of: navigationContext.interactor) == type(of: interactor))
        XCTAssertTrue(type(of: navigationContext.view) == type(of: achievementsTableViewController))
        XCTAssertTrue(type(of: navigationContext.asViewController()) == type(of: achievementsTableViewController))

        expectation.fulfill()
        waitForExpectations(timeout: 10, handler: nil)
    }
}
