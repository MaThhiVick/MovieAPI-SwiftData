//
//  AppendIfNotContains.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

extension Array where Element: Equatable {
    mutating func appendIfNotContains(_ element: Element) {
        if !contains(element) {
            insert(element, at: 0)
        }
    }
}
