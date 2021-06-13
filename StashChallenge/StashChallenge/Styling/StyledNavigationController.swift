//
//  StyledNavigationController.swift
//  StashChallenge
//
//  Created by Ace Green on 6/12/21.
//

import Foundation
import UIKit

public class StyledNavigationController: UINavigationController {

    private let navigationBarBackgroundColor = UIColor(red: 105 / 255, green: 62 / 255, blue: 203 / 255, alpha: 1)

    enum ButtonAppearanceType {
        case back, plain, done
    }

    @available(iOS 13.0, *)
    var styledAppearance: UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = navigationBarBackgroundColor
        appearance.titleTextAttributes = getTitleTextAttributes()
        appearance.largeTitleTextAttributes = getLargeTitleTextAttributes()
        appearance.backButtonAppearance = buttonAppearance(for: .back)
        appearance.setBackIndicatorImage(UIImage(systemName: "chevron.left"),
                                         transitionMaskImage: UIImage(systemName: "chevron.left"))
        appearance.buttonAppearance = buttonAppearance(for: .plain)
        appearance.doneButtonAppearance = buttonAppearance(for: .done)
        return appearance
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    open override var childForStatusBarStyle: UIViewController? {
        return nil
    }

    public var prefersLargeTitles: Bool = false {
        didSet {
            navigationBar.prefersLargeTitles = prefersLargeTitles
        }
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setStyle()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setStyle()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setStyle()
    }

    private func setStyle() {
        navigationBar.tintColor = UIColor.white
        navigationBar.backgroundColor = navigationBarBackgroundColor
        navigationBar.isTranslucent = false
        prefersLargeTitles = false

        navigationBar.standardAppearance = styledAppearance
        navigationBar.compactAppearance = styledAppearance
        navigationBar.scrollEdgeAppearance = styledAppearance
    }

    @available(iOS 13.0, *)
    private func buttonAppearance(for type: ButtonAppearanceType) -> UIBarButtonItemAppearance {
        let buttonAppearance = UIBarButtonItemAppearance()
        let normalState = buttonAppearance.normal
        let selectedState = buttonAppearance.highlighted
        switch type {
        case .back:
            normalState.titleTextAttributes = getBackButtonTitleTextAttributes(for: .normal)
            selectedState.titleTextAttributes = getBackButtonTitleTextAttributes(for: .selected)
        case .done:
            normalState.titleTextAttributes = getDoneButtonTitleTextAttributes(for: .normal)
            selectedState.titleTextAttributes = getDoneButtonTitleTextAttributes(for: .selected)
        case .plain:
            normalState.titleTextAttributes = getDefaultButtonTitleTextAttributes(for: .normal)
            selectedState.titleTextAttributes = getDefaultButtonTitleTextAttributes(for: .selected)
        }
        return buttonAppearance
    }

    private func getTitleTextAttributes() -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    private func getLargeTitleTextAttributes() -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24),
                NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    private func getBackButtonTitleTextAttributes(for state: UIControl.State) -> [NSAttributedString.Key: Any] {
        switch state {
        case .selected:
            return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        default:
            return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }

    private func getDefaultButtonTitleTextAttributes(for state: UIControl.State) -> [NSAttributedString.Key: Any] {
        switch state {
        case .selected:
            return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        default:
            return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }

    private func getDoneButtonTitleTextAttributes(for state: UIControl.State) -> [NSAttributedString.Key: Any] {
        switch state {
        case .selected:
            return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        default:
            return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
}
