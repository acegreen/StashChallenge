//
//  AchievementsNavigationContext.swift
//  StashChallenge
//
//  Created by Ace Green on 6/12/21.
//

import Foundation
import UIKit
import AGViperKit

enum AchievementsNavigationContext: NavigationContext {
    case main

    var presenter: ModulePresenter {
        return AchievementsPresenter.shared
    }

    var interactor: ModuleInteractor {
        return AchievementsInteractor.shared
    }

    var router: ModuleRouter {
        return DefaultRouter()
    }

    var view: ModuleView {
        switch self {
        case .main:
            return AchievementsView(viewModel: AchievementsViewModel.makeMockAchievementsViewModel())
        }
    }
}
