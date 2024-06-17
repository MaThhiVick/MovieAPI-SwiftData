//
//  BundleMock.swift
//  MovieAPI&SwiftDataTests
//
//  Created by Matheus Vicente on 22/05/24.
//

import Foundation

class BundleMock: Bundle {
    var shouldReturnNil = false
    var shouldReturnString = false
    var dictToReturn = [String: Any]()

    override func object(forInfoDictionaryKey key: String) -> Any? {
        if shouldReturnNil {
            return nil
        }

        if shouldReturnString {
            return "test"
        }

        return dictToReturn
    }
}
