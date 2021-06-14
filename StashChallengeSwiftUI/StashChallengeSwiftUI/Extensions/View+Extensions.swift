//
//  View+Extensions.swift
//  StashChallengeSwiftUI
//
//  Created by Ace Green on 6/14/21.
//

import SwiftUI

public extension View {
  func navigationBarColor(_ backgroundColor: UIColor, textColor: UIColor) -> some View {
    self.modifier(StyledNavigationBarModifier(backgroundColor: backgroundColor, textColor: textColor))
  }
}

public extension View {
    var purpleNavigation: some View {
        self.navigationBarColor(UIColor(red: 105 / 255, green: 62 / 255, blue: 203 / 255, alpha: 1), textColor: .white)
    }
}
