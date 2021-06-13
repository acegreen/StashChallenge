//
//  ModuleInteractor+Extensions.swift
//  AGViperKit
//
//  Created by Ace Green on 6/12/21.
//

import Foundation

public class DefaultInteractor: ModuleInteractor {
    public init() {}
}

public extension ModuleInteractor {

    // empty implementation by default
    func configure(presenter: ModulePresenter) { }

    #if DEBUG
    func getLocalObject<T>(type: T.Type,
                           fromFileName fileName: String,
                           fileExtension: String = "json",
                           latency: Int = 0,
                           jsonDecoder: JSONDecoder = JSONDecoder(),
                           completionHandler: @escaping (T?) -> Void) where T: Decodable {

        DispatchQueue.global().async {
            if let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
                do {
                    let data = try Data(contentsOf: url)
                    let result = try jsonDecoder.decode(type.self, from: data)
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(latency)) {
                        completionHandler(result)
                    }

                } catch let error {
                    print(error)
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(latency)) {
                        completionHandler(nil)
                    }
                }
            }

        }
    }
    #endif
}
