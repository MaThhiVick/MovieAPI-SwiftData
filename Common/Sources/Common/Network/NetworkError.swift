//
//  File.swift
//  
//
//  Created by Matheus Vicente on 20/05/24.
//

import Foundation

public enum NetworkError: Error {
    case errorRequest
}

extension NetworkError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .errorRequest:
            return "Error ocurred manking request"
        }
    }
}

