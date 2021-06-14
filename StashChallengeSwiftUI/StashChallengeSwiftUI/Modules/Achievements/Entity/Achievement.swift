//
//  Achievement.swift
//  StashChallenge
//
//  Created by Ace Green on 6/12/21.
//

import Foundation

public class AchievementOverview: Codable {
    let title: String
}

public class Achievement: Codable {
    let id: Int
    let level: String
    let progress: Int
    let total: Int
    let imageURL: String
    let accessible: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case level
        case progress
        case total
        case imageURL = "bg_image_url"
        case accessible
    }

    public init(id: Int, level: String, progress: Int, total: Int, imageURL: String, accessible: Bool) {
        self.id = id
        self.level = level
        self.progress = progress
        self.total = total
        self.imageURL = imageURL
        self.accessible = accessible
    }

    public func getImageURL() -> URL? {
        return URL(string: imageURL)
    }
}

public class Achievements: Codable {
    let success: Bool
    let status: Int
    let overview: AchievementOverview
    let achievements: [Achievement]
}
