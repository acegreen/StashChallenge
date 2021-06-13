//
//  ModuleView.swift
//  AGViperKit
//
//  Created by Ace Green on 6/12/21.
//

import Foundation
import UIKit

/// Types adopting the `ModuleView` protocol can be used to safely construct `UIViewController`s.
public protocol ModuleView: AnyObject {
    func configure(presenter: ModulePresenter)
    func asViewController() -> UIViewController
}

public extension ModuleView where Self: UIViewController {
    func asViewController() -> UIViewController {
        return self
    }
}
