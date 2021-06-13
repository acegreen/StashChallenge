//
//  StashChallengePresenterTests.swift
//  StashChallengeTests
//
//  Created by Ace Green on 6/13/21.
//

import XCTest
import AGViperKit
@testable import StashChallenge

class StashChallengePresenterTests: XCTestCase {

    lazy var presenter: AchievementsPresenter = {
        let interactor = AchievementsInteractor.shared
        let presenter = AchievementsPresenter.shared
        let achievementsTableViewController = UIStoryboard.achievements.controller(class: AchievementsTableViewController.self)
        presenter.configure(view: achievementsTableViewController, interactor: interactor, router: DefaultRouter())
        return presenter
    }()

    func testUpdateViews() throws {

        let expectation = self.expectation(description: "expectation")

        presenter.updateView()
        .done { achievements in
            let firstAchievement = achievements.achievementViewModels.first
            XCTAssertNotNil(achievements)
            XCTAssertEqual(firstAchievement?.level, "1")
            XCTAssertEqual(firstAchievement?.progress, 0.1)
            XCTAssertEqual(firstAchievement?.minLabel, "10pts")
            XCTAssertEqual(firstAchievement?.maxLabel, "50pts")
            XCTAssertTrue(firstAchievement?.accessible == true)
        }.catch { error in
            XCTFail(error.localizedDescription)
        }.finally {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testAchievementAtIndexZero() throws {

        let expectation = self.expectation(description: "expectation")

        presenter.updateView().done { _ in
            let achievementAtIndexZero = self.presenter.getAchievement(at: 0)

            let imageURL = URL(string: "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/C850B103-B8C5-4518-8631-168BB42FFBBD.png")
            let mockAchievement = AchievementViewModel(level: "1",
                                                       progress: 0.1,
                                                       minLabel: "10pts",
                                                       maxLabel: "50pts",
                                                       imageURL: imageURL,
                                                       accessible: true)
            XCTAssertEqual(achievementAtIndexZero, mockAchievement)
        }.catch { error in
            XCTFail(error.localizedDescription)
        }.finally {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testAchievementsCount() throws {

        let expectation = self.expectation(description: "expectation")

        presenter.updateView().done { _ in
            XCTAssertEqual(self.presenter.getAchievementsCount(), 3)
        }.catch { error in
            XCTFail(error.localizedDescription)
        }.finally {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
}
