//
//  SGError.swift
//  
//
//  Created by Rehan Ali on 16/09/2022.
//

import Foundation

public enum SGError: Error {
    case jsonCorrupted
}

extension SGError {
    var localizedDescription: String {
        switch self {
            case .jsonCorrupted: return "JSON is not valid."
        }
    }
}
