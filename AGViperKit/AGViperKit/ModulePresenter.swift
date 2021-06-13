//
//  ModuleView.swift
//  AGViperKit
//
//  Created by Ace Green on 6/12/21.
//

import Foundation

public protocol ModulePresenter: AnyObject {
    func configure(view: ModuleView, interactor: ModuleInteractor, router: ModuleRouter)
}
