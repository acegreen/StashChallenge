//
//  AchievementsTableViewController.swift
//  StashChallenge
//
//  Created by Ace Green on 6/12/21.
//

import UIKit
import AGViperKit

protocol AchievementsModuleView: ModuleView {}

class AchievementsTableViewController: UITableViewController, AchievementsModuleView {

    struct AchievementsCellIdentifier {
        static let achievementsCell = "AchievementsTableViewCell"
    }

    var presenter: AchievementsModulePresenter!

    var achievementsModel: AchievementsViewModel? {
        didSet {
            title = NSLocalizedString(achievementsModel?.title ?? "", comment: "")
            tableView.reloadData()
        }
    }

    func configure(presenter: ModulePresenter) {
        assert(presenter is AchievementsModulePresenter, "presenter parameter must be of type AchievementsModulePresenter")
        self.presenter = presenter as? AchievementsModulePresenter
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyling()
        fetchData()
    }

    private func setStyling() {
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                                           style: .plain,
                                                           target: self,
                                                           action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
    }

    private func fetchData() {
        presenter.updateView().done { [weak self] (achievements: AchievementsViewModel) in
            self?.achievementsModel = achievements
        }.catch { _ in
            // TODO[XXXX]: Show error
        }
    }

    // MARK: - UITableViewDataSource protocol conformance

    override func tableView(_ tableView: UITableView,
                            heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getAchievementsCount() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: AchievementsCellIdentifier.achievementsCell,
                                                       for: indexPath) as? AchievementsTableViewCell,
              let achievementViewModelAtIndex = presenter.getAchievement(at: indexPath.row) else { return UITableViewCell() }

        cell.configure(level: achievementViewModelAtIndex.level,
                       progress: achievementViewModelAtIndex.progress,
                       minLabel: achievementViewModelAtIndex.minLabel,
                       maxLabel: achievementViewModelAtIndex.maxLabel,
                       imageURL: achievementViewModelAtIndex.imageURL,
                       accessible: achievementViewModelAtIndex.accessible)

        return cell
    }
}
