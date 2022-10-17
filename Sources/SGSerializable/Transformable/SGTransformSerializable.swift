//
// SGTransformSerializable.swift
// SGSerializable
//
// Created by Rehan Ali on 09/10/2022 at 7:53 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

    /// This wrapper class used for any custom transformation.
    ///
    /// You must provide custom implementation of `SGTranformable` which is needed for transformation.
@propertyWrapper
public final class SGTransformSerializable<Value: SGTranformable> {
    public var wrappedValue: Value.ToType?
    public var name: String?
    
    public var projectedValue: Value.ToType {
        set { wrappedValue = newValue }
        get {
            guard let wrappedValue else {
                return getFallBack(Value.ToType.self)
            }
            return wrappedValue
        }
    }
    
    public init(default value: Value.ToType? = nil, key: String? = nil) {
        self.wrappedValue = value
        self.name = key
    }
}

extension SGTransformSerializable {
    internal func getKey(with key: String) -> SGCodingKey {
        let cKey: SGCodingKey!
        if let name = name, !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            cKey = SGCodingKey(name: name)
        }else {
            cKey = SGCodingKey(name: key)
        }
        return cKey
    }
}
