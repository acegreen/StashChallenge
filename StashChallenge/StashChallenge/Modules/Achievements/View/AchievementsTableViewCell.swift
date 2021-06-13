//
//  AchievementsTableViewCell.swift
//  StashChallenge
//
//  Created by Ace Green on 6/12/21.
//

import UIKit
import SDWebImage

class AchievementsTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!

    @IBOutlet weak var levelSubtitleLabel: UILabel!

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressMinLabel: UILabel!
    @IBOutlet weak var progressMaxLabel: UILabel!

    // MARK: - Methods

    func configure(level: String, progress: Float, minLabel: String, maxLabel: String, imageURL: URL?, accessible: Bool) {

        backgroundImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        backgroundImageView.sd_imageIndicator?.startAnimatingIndicator()
        backgroundImageView.sd_setImage(with: imageURL) { [weak self] _, _, _, _  in
            self?.backgroundImageView.alpha = accessible ? 1 : 0.5
            self?.backgroundImageView.sd_imageIndicator?.stopAnimatingIndicator()
        }

        levelSubtitleLabel.text = level
        progressView.progress = progress
        progressMinLabel.text = minLabel
        progressMaxLabel.text = maxLabel

        accessibilityIdentifier = "Achievement Level \(level)"
        accessibilityLabel = "Achievement Level \(level)"
    }
}
