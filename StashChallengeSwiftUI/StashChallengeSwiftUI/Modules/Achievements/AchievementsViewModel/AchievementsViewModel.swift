//
//  AchievementsViewModel.swift
//  StashChallenge
//
//  Created by Ace Green on 6/12/21.
//

import Foundation
import SwiftUI

public class AchievementViewModel: Equatable, Identifiable {
    public var id: String
    let level: String
    let progress: Float
    let minLabel: String
    let maxLabel: String
    let imageURL: URL?
    let accessible: Bool

    public init(id: String, level: String, progress: Float, minLabel: String, maxLabel: String, imageURL: URL?, accessible: Bool) {
        self.id = id
        self.level = level
        self.progress = progress
        self.minLabel = minLabel
        self.maxLabel = maxLabel
        self.imageURL = imageURL
        self.accessible = accessible
    }
}

public func == (lhs: AchievementViewModel, rhs: AchievementViewModel) -> Bool {
    return lhs.id == rhs.id &&
        lhs.level == rhs.level &&
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

    static func makeMockAchievementsViewModel() -> AchievementsViewModel {

        let mockAchievementViewModel1 = AchievementViewModel(id: "4",
                                                             level: "1",
                                                             progress: 0.1,
                                                             minLabel: "10pts",
                                                             maxLabel: "50pts",
                                                             imageURL: URL(string: "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/C850B103-B8C5-4518-8631-168BB42FFBBD.png"),
                                                             accessible: true)
        let mockAchievementViewModel2 = AchievementViewModel(id: "3",
                                                             level: "2",
                                                             progress: 0,
                                                             minLabel: "0pts",
                                                             maxLabel: "50pts",
                                                             imageURL: URL(string: "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/341E40C8-1C2A-400C-B67D-F490B74BDD81.png"),
                                                             accessible: false)
        let mockAchievementViewModel3 = AchievementViewModel(id: "5",
                                                             level: "3",
                                                             progress: 0,
                                                             minLabel: "0pts",
                                                             maxLabel: "50pts",
                                                             imageURL: URL(string: "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/C60F6868-A0CD-4D9D-A3B9-3C460FA989FF.png"),
                                                             accessible: false)
        return AchievementsViewModel(title: "Smart Investing",
                                     achievementViewModels: [mockAchievementViewModel1,
                                                             mockAchievementViewModel2,
                                                             mockAchievementViewModel3])
    }
}
