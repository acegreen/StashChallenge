//
//  AchievementsViewModel.swift
//  StashChallenge
//
//  Created by Ace Green on 6/12/21.
//

import Foundation

public class AchievementViewModel: Codable, Equatable {
    let level: String
    let progress: Float
    let minLabel: String
    let maxLabel: String
    let imageURL: URL?
    let accessible: Bool

    public init(level: String, progress: Float, minLabel: String, maxLabel: String, imageURL: URL?, accessible: Bool) {
        self.level = level
        self.progress = progress
        self.minLabel = minLabel
        self.maxLabel = maxLabel
        self.imageURL = imageURL
        self.accessible = accessible
    }
}

public func == (lhs: AchievementViewModel, rhs: AchievementViewModel) -> Bool {
    return lhs.level == rhs.level &&
        lhs.progress == rhs.progress &&
        lhs.minLabel == rhs.minLabel &&
        lhs.maxLabel == rhs.maxLabel &&
        lhs.imageURL == rhs.imageURL &&
        lhs.accessible == rhs.accessible
}

public class AchievementsViewModel: Codable {
    let title: String
    let achievementViewModels: [AchievementViewModel]

    public init(title: String, achievementViewModels: [AchievementViewModel]) {
        self.title = title
        self.achievementViewModels = achievementViewModels
    }
}
