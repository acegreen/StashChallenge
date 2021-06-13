//
//  AchievementsInteractor.swift
//  StashChallenge
//
//  Created by Ace Green on 6/12/21.
//

import Foundation
import AGViperKit
import PromiseKit

public enum AchievementsError: Error {
    case noResults

    // MARK: Override Error+Log

    var reasonString: String {
        return "\(self)"
    }
}

protocol AchievementsModuleInteractor: ModuleInteractor {
    var achievements: Achievements? { get }
    func fetchAchievements() -> Promise<Achievements>
}

class AchievementsInteractor: AchievementsModuleInteractor {

    static let shared = AchievementsInteractor()

    weak var presenter: AchievementsModulePresenter?
    var achievements: Achievements?

    func configure(presenter: ModulePresenter) {
        assert(presenter is AchievementsModulePresenter)
        self.presenter = presenter as? AchievementsModulePresenter
    }

    func fetchAchievements() -> Promise<Achievements> {
        return Promise { result in
            getLocalObject(type: Achievements.self, fromFileName: "Achievements") { (object: Achievements?) in
                if let achievementModel: Achievements = object {
                    result.resolve(achievementModel, nil)
                    self.achievements = achievementModel
                } else {
                    result.resolve(nil, AchievementsError.noResults)
                }
            }
        }
    }
}
