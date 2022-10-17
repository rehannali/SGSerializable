//
// NSDictionary+Extension.swift
// SGSerializable
//
// Created by Rehan Ali on 07/10/2022 at 7:59 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

public extension NSDictionary {
        /// Get swift Dictionary from `NSDictionary`
    var swiftDictionary: [String: Any] {
        var dict: [String: Any] = [:]
        let keys = allKeys.compactMap{ $0 as? String }
        for key in keys {
            dict[key] = unwrap(convertObjectsToSwiftDictionary(self[key] as Any))
        }
        return dict
    }
    
        /// Iterate over object while making dictionary
        /// - Parameter object: Any object conform to `NSObject/NSObjectProtocol`
        /// - Returns: Object attribute value
    private func convertObjectsToSwiftDictionary(_ object: Any) -> Any {
        if (object as? Int) != nil
            || (object as? Double) != nil
            || (object as? Float) != nil
            || (object as? CGFloat) != nil
            || (object as? Bool) != nil
            || (object as? String) != nil {
            return unwrap(object)
        }
        
        if (object as? [Int]) != nil
            || (object as? [Double]) != nil
            || (object as? [Float]) != nil
            || (object as? [CGFloat]) != nil
            || (object as? [Bool]) != nil
            || (object as? [String]) != nil {
            return unwrap(object)
        }
        
        if let values = object as? [[String: Any]] {
            for value in values {
                return convertObjectsToSwiftDictionary(value)
            }
        }
        
        if let value = object as? [String: Any] {
            var dict: [String: Any] = [:]
            let keys = value.keys
            for key in keys {
                dict[key] = convertObjectsToSwiftDictionary(value[key] as Any)
                dict[key] = unwrap(dict[key])
            }
            return dict
        }
        
        return unwrap(object)
    }
}
