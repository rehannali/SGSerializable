//
//  NSObjectProtocol+Extension.swift
//
//  Created by Rehan Ali on 15/07/2020.
//  Copyright © 2020 Rehan Ali. All rights reserved.
//

import Foundation

public extension NSObjectProtocol {
    func toDictionaryString(withPrettyformat value: Bool = false) -> String {
        return JSONSerializer.toJson(self, prettify: value)
    }
    
    func toDictionary(withPrettyformat value: Bool = false) -> [String: Any] {
        guard let json = try? JSONSerializer.toDictionary(toDictionaryString(withPrettyformat: value)) else { return [:]}
        
        return json.swiftDictionary
    }
    
    func unwrap<T>(_ object: T) -> Any {
        let mirror = Mirror(reflecting: object)
        guard mirror.displayStyle == .optional, let first = mirror.children.first else { return object }
        return first.value
    }
}
