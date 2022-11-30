//
// NSObjectProtocol+Extension.swift
// SGSerializable
//
// Created by Rehan Ali on 07/10/2022 at 7:59 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

public extension NSObjectProtocol {
        /// Get JSON String from any class conform to `NSObject/NSObjectProtocol`
        /// - Parameter value: If you want to prettify JSON String. Default `false`
        /// - Returns: JSON String Based on your preference
    func toDictionaryString(withPrettyformat value: Bool = false) -> String {
        return JSONSerializer.toJson(self, prettify: value)
    }
    
        /// Get Swfit dictionary from any class conform to `NSObject/NSObjectProtocol`
        /// - Parameter value: If you want to prettify JSON String. Default `false`
        /// - Returns: Swift dictionary
    func toDictionary(withPrettyformat value: Bool = false) -> [String: Any] {
        guard let json = try? JSONSerializer.toDictionary(toDictionaryString(withPrettyformat: value)) else { return [:]}
        
        return json.swiftDictionary
    }
}

    /// Unwarp value of attribute if present
    /// - Parameter object: This can be anything like Int, Float, Dictionary, classes, struct etc
    /// - Returns: Unwarped value if present otherwise `nil`
public func unwrap<T>(_ object: T) -> Any {
    let mirror = Mirror(reflecting: object)
    guard mirror.displayStyle == .optional, let first = mirror.children.first else { return object }
    return first.value
}
