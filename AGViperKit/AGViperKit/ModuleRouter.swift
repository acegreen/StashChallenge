//
//  NavigationRouter.swift
//  AGViperKit
//
//  Created by Ace Green on 6/12/21.
//

import Foundation
import UIKit

public protocol ModuleRouter: AnyObject {
    func navigate(fromView view: ModuleView,
                  toContext context: NavigationContext,
                  style: NavigationStyle?,
                  animated: Bool,
                  completion: (() -> Void)?)
    func embed(context: NavigationContext) -> ModuleView
}

public class DefaultRouter: ModuleRouter {
    public init() {}
}

public extension ModuleRouter {
    func navigate(fromView view: ModuleView,
                  toContext context: NavigationContext,
                  style: NavigationStyle? = .pushed,
                  animated: Bool = true,
                  completion: (() -> Void)? = nil) {
        func makeController(withNavigationController: Bool, withTabBarController: Bool) -> UIViewController {
            let navigationController = UINavigationController(rootViewController: context.asViewController())
            let tabBarController = UITabBarController()

            switch (withTabBarController, withNavigationController) {
            case (true, true):
                tabBarController.setViewControllers([navigationController], animated: false)
                return tabBarController
            case (true, false):
                return tabBarController
            case (false, true):
                return navigationController
            case (false, false):
                return context.asViewController()
            }
        }
        if let style = style {
            switch style {
            case .pushed:
                view.asViewController().navigationController?.pushViewController(context.asViewController(), animated: animated)
            case let .presented(withNavigationController, withTabBarController, fullScreen):
                let viewController = makeController(withNavigationController: withNavigationController, withTabBarController: withTabBarController)
                fullScreen ? viewController.modalPresentationStyle = .fullScreen : nil
                view.asViewController().present(viewController, animated: animated, completion: completion)
            case .custom(let segue):
                segue.perform()
            }
        }
    }

    func embed(context: NavigationContext) -> ModuleView {
        return context.asViewController() as! ModuleView // swiftlint:disable:this force_cast
    }
}
