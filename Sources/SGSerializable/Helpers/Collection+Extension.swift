//
//  Collection+Extension.swift
//
//  Created by Rehan Ali on 20/07/2020.
//  Copyright © 2020 Rehan Ali. All rights reserved.
//

import Foundation

public protocol NullOrDefaultValuesStripable {
    func strippingNullOrDefaults() -> Self
}

extension Array: NullOrDefaultValuesStripable {
    public func strippingNullOrDefaults() -> Self {
        return compactMap {
            switch $0 {
                case let stripable as NullOrDefaultValuesStripable:
                    return (stripable.strippingNullOrDefaults() as! Element)
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
                    return (stripable.strippingNullOrDefaults() as! Value)
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
