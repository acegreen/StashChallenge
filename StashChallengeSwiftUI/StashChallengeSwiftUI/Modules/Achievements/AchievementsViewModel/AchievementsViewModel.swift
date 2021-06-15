//
//  AchievementsViewModel.swift
//  StashChallenge
//
//  Created by Ace Green on 6/12/21.
//

import Foundation
import SwiftUI

public class AchievementViewModel: Equatable, Identifiable {
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

public class AchievementsViewModel: ObservableObject {
    let title: String

    @Published var error: Bool = false {
        willSet {
            self.objectWillChange.send()
        }
    }

    @Published var achievementViewModels: [AchievementViewModel] = [] {
       willSet {
            self.objectWillChange.send()
        }
    }

    public init(title: String, achievementViewModels: [AchievementViewModel]) {
        self.title = title
        self.achievementViewModels = achievementViewModels
    }

    public convenience init() {
        self.init(title: "", achievementViewModels: [])
    }
}
