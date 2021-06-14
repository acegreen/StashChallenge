//
//  StyledNavigationBarModifier.swift
//  StashChallengeSwiftUI
//
//  Created by Ace Green on 6/14/21.
//

import Foundation
import SwiftUI

struct StyledNavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor
    var textColor: UIColor

    enum ButtonAppearanceType {
        case back, plain, done
    }

    var styledAppearance: UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = getTitleTextAttributes()
        appearance.largeTitleTextAttributes = getLargeTitleTextAttributes()
        appearance.backButtonAppearance = buttonAppearance(for: .back)
        appearance.setBackIndicatorImage(UIImage(systemName: "chevron.left"),
                                         transitionMaskImage: UIImage(systemName: "chevron.left"))
        appearance.buttonAppearance = buttonAppearance(for: .plain)
        appearance.doneButtonAppearance = buttonAppearance(for: .done)
        return appearance
    }

    init(backgroundColor: UIColor, textColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor

        UINavigationBar.appearance().standardAppearance = styledAppearance
        UINavigationBar.appearance().compactAppearance = styledAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = styledAppearance
        UINavigationBar.appearance().tintColor = textColor
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
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
