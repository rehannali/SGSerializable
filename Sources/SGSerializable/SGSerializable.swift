//
//  SGSerializable.swift
//
//
//  Created by Rehan Ali on 16/09/2022.
//

import Foundation

@propertyWrapper
public final class SGSerializable<Value> {
    public var wrappedValue: Value
    public var name: String?
    
    public init(wrappedValue: Value, name: String? = nil) {
        self.wrappedValue = wrappedValue
        self.name = name
    }
}

extension SGSerializable {
    internal func getKey(with key: String) -> SGCodingKey {
        let cKey: SGCodingKey!
        if let name = name, !name.isEmpty {
            cKey = SGCodingKey(name: name)
        }else {
            cKey = SGCodingKey(name: key)
        }
        return cKey
    }
}
