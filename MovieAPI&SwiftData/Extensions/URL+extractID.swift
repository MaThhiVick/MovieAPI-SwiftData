//
//  URL+extractId.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 18/06/24.
//

import Foundation

extension URL {
    func extractID() -> Int? {
        if let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false),
            let queryItems = urlComponents.queryItems,
            let idItem = queryItems.first(where: { $0.name == "id" }),
            let id = Int(idItem.value ?? "") {
            return id
        }
        return nil
    }
}
