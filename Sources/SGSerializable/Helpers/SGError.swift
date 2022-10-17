//
// SGError.swift
// SGSerializable
//
// Created by Rehan Ali on 07/10/2022 at 7:53 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
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
