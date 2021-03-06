//
//  AchievementsPresenter.swift
//  StashChallenge
//
//  Created by Ace Green on 6/12/21.
//

import Foundation
import AGViperKit
import PromiseKit

protocol AchievementsModulePresenter: ModulePresenter {
    func updateView() async throws -> AchievementsViewModel

    func getAchievementsCount() -> Int?
    func getAchievement(at index: Int) -> AchievementViewModel?
}

class AchievementsPresenter: AchievementsModulePresenter {

    static let shared = AchievementsPresenter()

    var view: AchievementsModuleView!
    var router: DefaultRouter!
    var interactor: AchievementsModuleInteractor!

    func configure(view: ModuleView, interactor: ModuleInteractor, router: ModuleRouter) {
        assert(view is AchievementsModuleView)
        assert(interactor is AchievementsModuleInteractor)

        self.view = view as? AchievementsModuleView
        self.router = router as? DefaultRouter
        self.interactor = interactor as? AchievementsModuleInteractor
    }

    func updateView() async throws -> AchievementsViewModel {
        let achievements = try await interactor.fetchAchievements()
        return achievements.asAchievementsViewModel()
    }

    func getAchievementsCount() -> Int? {
        return interactor.achievements?.achievements.count
    }

    func getAchievement(at index: Int) -> AchievementViewModel? {
        return interactor?.achievements?.achievements[index].asAchievementViewModel()
    }
}

extension Achievements {
    func asAchievementsViewModel() -> AchievementsViewModel {
        let achievementViewModels = achievements.map { achievement in
            return AchievementViewModel(id: String(achievement.id),
                                        level: achievement.level,
                                        progress: Float(Double(achievement.progress)) / 100,
                                        minLabel: "\(achievement.progress)pts",
                                        maxLabel: "\(achievement.total)pts",
                                        imageURL: achievement.getImageURL(),
                                        accessible: achievement.accessible)
        }
        return AchievementsViewModel(title: overview.title, achievementViewModels: achievementViewModels)
    }
}

extension Achievement {
    func asAchievementViewModel() -> AchievementViewModel {
        return AchievementViewModel(id: String(id),
                                    level: level,
                                    progress: Float(Double(progress)) / 100,
                                    minLabel: "\(progress)pts",
                                    maxLabel: "\(total)pts",
                                    imageURL: getImageURL(),
                                    accessible: accessible)
    }
}
