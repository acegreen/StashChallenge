//
//  NavigationContext.swift
//  AGViperKit
//
//  Created by Ace Green on 6/12/21.
//

import Foundation
import UIKit

public protocol NavigationContext {
    var presenter: ModulePresenter { get }
    var interactor: ModuleInteractor { get }
    var router: ModuleRouter { get }
    var view: ModuleView { get }

    func asViewController() -> UIViewController
}

public extension NavigationContext {
    func asViewController() -> UIViewController {
        let contextPresenter = presenter
        let contextInteractor = interactor
        let contextRouter = router
        var contextView = view

        contextPresenter.configure(view: contextView, interactor: contextInteractor, router: contextRouter)
        contextInteractor.configure(presenter: contextPresenter)
        contextView.configure(presenter: contextPresenter)

        return contextView.asViewController()
    }
}

public enum NavigationStyle {
    case pushed
    case presented(withNavigationController: Bool = false, withTabBarController: Bool = false, fullScreen: Bool = false)
    case custom(segue: UIStoryboardSegue)
}
