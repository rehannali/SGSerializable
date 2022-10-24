//
// Collection+Extension.swift
// SGSerializable
//
// Created by Rehan Ali on 07/10/2022 at 7:59 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

    /// This is used for removed defaults or null values from Collections.
public protocol NullOrDefaultValuesStripable {
    func strippingNullOrDefaults() -> Self
}

extension Array: NullOrDefaultValuesStripable {
    public func strippingNullOrDefaults() -> Self {
        return compactMap {
            switch $0 {
                case let stripable as NullOrDefaultValuesStripable:
                    guard let value = stripable.strippingNullOrDefaults() as? Element else { return nil }
                    if let dict = value as? [String: Any], dict.isEmpty {
                        return nil
                    }else if let array = value as? [Any], array.isEmpty {
                        return nil
                    }
                    return value
                case is NSNull:
                    return nil
                case is String:
                    if let stringValue = $0 as? String, stringValue.isEmpty || ["<null>", "nil", "null"].contains(stringValue.lowercased()) {
                        return nil
                    }else {
                        return $0
                }
                case is Int:
                    if let value = $0 as? Int, value < 0 {
                        return nil
                    }else {
                        return $0
                    }
                case is Double:
                    if let value = $0 as? Double, value < 0 {
                        return nil
                    }else {
                        return $0
                    }
                case is Float:
                    if let value = $0 as? Float, value < 0 {
                        return nil
                    }else {
                        return $0
                    }
                case is CGFloat:
                    if let value = $0 as? CGFloat, value < 0 {
                        return nil
                    }else {
                        return $0
                    }
                default:
                    return $0
            }
        }
    }
}

extension Dictionary: NullOrDefaultValuesStripable {
    public func strippingNullOrDefaults() -> Self {
        return compactMapValues {
            switch $0 {
                case let stripable as NullOrDefaultValuesStripable:
                    guard let value = stripable.strippingNullOrDefaults() as? Value else { return nil }
                    if let dict = value as? [String: Any], dict.isEmpty {
                        return nil
                    }else if let array = value as? [Any], array.isEmpty {
                        return nil
                    }
                    return value
                case is NSNull:
                    return nil
                case is String:
                    if let stringValue = $0 as? String, stringValue.isEmpty || ["<null>", "nil", "null"].contains(stringValue.lowercased()) {
                        return nil
                    }else {
                        return $0
                }
                case is Int:
                    if let value = $0 as? Int, value < 0 {
                        return nil
                    }else {
                        return $0
                }
                case is Double:
                    if let value = $0 as? Double, value < 0 {
                        return nil
                    }else {
                        return $0
                    }
                case is Float:
                    if let value = $0 as? Float, value < 0 {
                        return nil
                    }else {
                        return $0
                    }
                case is CGFloat:
                    if let value = $0 as? CGFloat, value < 0 {
                        return nil
                    }else {
                        return $0
                    }
                default:
                    return $0
            }
        }
    }
}
