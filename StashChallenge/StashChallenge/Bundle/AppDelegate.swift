//
//  AppDelegate.swift
//  StashChallenge
//
//  Created by Ace Green on 6/12/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let achievementsViewController = AchievementsNavigationContext.main.asViewController()
        let navigationViewController = StyledNavigationController(rootViewController: achievementsViewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()

        return true
    }
}
