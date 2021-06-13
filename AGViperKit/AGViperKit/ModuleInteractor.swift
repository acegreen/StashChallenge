//
//  ModuleInteractor.swift
//  AGViperKit
//
//  Created by Ace Green on 6/12/21.
//

import Foundation

public protocol ModuleInteractor: AnyObject {
    func configure(presenter: ModulePresenter)
    func getLocalObject<T>(type: T.Type,
                           fromFileName fileName: String,
                           fileExtension: String,
                           latency: Int,
                           jsonDecoder: JSONDecoder,
                           completionHandler: @escaping (T?) -> Void) where T: Decodable
}
