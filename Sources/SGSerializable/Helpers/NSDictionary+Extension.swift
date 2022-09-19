//
//  NSDictionary+Extension.swift
//
//  Created by Rehan Ali on 16/07/2020.
//  Copyright © 2020 Rehan Ali. All rights reserved.
//

import Foundation

public extension NSDictionary {
    var swiftDictionary: [String: Any] {
        var dict: [String: Any] = [:]
        let keys = allKeys.compactMap{ $0 as? String }
        for key in keys {
            dict[key] = unwrap(convertObjectsToSwiftDictionary(self[key] as Any))
        }
        return dict
    }
    
    private func convertObjectsToSwiftDictionary(_ object: Any) -> Any {
        if let _ = object as? Int,
           let _ = object as? Double,
           let _ = object as? Float,
           let _ = object as? CGFloat,
           let _ = object as? Bool,
           let _ = object as? String{
            return unwrap(object)
        }
        
        if let _ = object as? [Int],
           let _ = object as? [Double],
           let _ = object as? [Float],
           let _ = object as? [CGFloat],
           let _ = object as? [Bool],
           let _ = object as? [String] {
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
