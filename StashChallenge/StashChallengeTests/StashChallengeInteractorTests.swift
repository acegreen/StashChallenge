//
//  StashChallengeInteractorTests.swift
//  StashChallengeTests
//
//  Created by Ace Green on 6/12/21.
//

import XCTest
@testable import StashChallenge

class StashChallengeInteractorTests: XCTestCase {

    let interactor = AchievementsInteractor()

    func testFetchAchievements() throws {

        let expectation = self.expectation(description: "expectation")

        interactor.fetchAchievements()
        .done { achievements in
            let firstAchievement = achievements.achievements.first
            XCTAssertNotNil(achievements)
            XCTAssertEqual(firstAchievement?.id, 4)
            XCTAssertEqual(firstAchievement?.level, "1")
            XCTAssertEqual(firstAchievement?.progress, 10)
            XCTAssertEqual(firstAchievement?.total, 50)
            XCTAssertTrue(firstAchievement?.accessible == true)
        }.catch { error in
            XCTFail(error.localizedDescription)
        }.finally {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testAchievementsAsAchivementViewModels() throws {

        let expectation = self.expectation(description: "expectation")

        let imageURL = URL(string: "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/C850B103-B8C5-4518-8631-168BB42FFBBD.png")
        interactor.fetchAchievements()
        .done { achievements in

            let achivementViewModels = achievements.achievements.map { $0.asAchievementViewModel() }
            XCTAssertNotNil(achivementViewModels)
            let firstAchivementViewModel = achivementViewModels.first
            XCTAssertEqual(firstAchivementViewModel?.level, "1")
            XCTAssertEqual(firstAchivementViewModel?.progress, 0.1)
            XCTAssertEqual(firstAchivementViewModel?.minLabel, "10pts")
            XCTAssertEqual(firstAchivementViewModel?.maxLabel, "50pts")
            XCTAssertEqual(firstAchivementViewModel?.imageURL, imageURL)
            XCTAssertTrue(firstAchivementViewModel?.accessible == true)
        }.catch { error in
            XCTFail(error.localizedDescription)
        }.finally {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testAchievementAsAchivementViewModel() throws {

        let expectation = self.expectation(description: "expectation")

        let imageURL = URL(string: "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/C850B103-B8C5-4518-8631-168BB42FFBBD.png")
        interactor.fetchAchievements()
        .done { achievements in

            let achivementViewModel = achievements.achievements[0].asAchievementViewModel()
            XCTAssertNotNil(achivementViewModel)
            XCTAssertEqual(achivementViewModel.level, "1")
            XCTAssertEqual(achivementViewModel.progress, 0.1)
            XCTAssertEqual(achivementViewModel.minLabel, "10pts")
            XCTAssertEqual(achivementViewModel.maxLabel, "50pts")
            XCTAssertEqual(achivementViewModel.imageURL, imageURL)
            XCTAssertTrue(achivementViewModel.accessible == true)
        }.catch { error in
            XCTFail(error.localizedDescription)
        }.finally {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
}
