//
//  AchievementsInteractor.swift
//  StashChallenge
//
//  Created by Ace Green on 6/12/21.
//

import Foundation
import AGViperKit
import Combine

public enum AchievementsError: Error {
    case noResults

    // MARK: Override Error+Log

    var reasonString: String {
        return "\(self)"
    }
}

protocol AchievementsModuleInteractor: ModuleInteractor {
    var achievements: Achievements? { get }
    func fetchAchievements() async throws -> Achievements
}

class AchievementsInteractor: AchievementsModuleInteractor {

    static let shared = AchievementsInteractor()

    weak var presenter: AchievementsModulePresenter?
    var achievements: Achievements?

    func configure(presenter: ModulePresenter) {
        assert(presenter is AchievementsModulePresenter)
        self.presenter = presenter as? AchievementsModulePresenter
    }

    func fetchAchievements() async throws -> Achievements {
        return try await withUnsafeThrowingContinuation { continuation in
            getLocalObject(type: Achievements.self, fromFileName: "Achievements") { (object: Achievements?) in
                if let achievements: Achievements = object {
                    self.achievements = achievements
                    continuation.resume(returning: achievements)
                } else {
                    continuation.resume(throwing: AchievementsError.noResults)
                }
            }
        }
    }
}
