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
public final class SGTransformSerializable<Transform: SGTranformable> {
    internal var _wrappedValue: Transform.ToType?
    public var name: String?
    
    public var wrappedValue: Transform.ToType {
        set { _wrappedValue = newValue }
        get {
            guard let safeValue = _wrappedValue else {
                return getFallBack(Transform.ToType.self)
            }
            return safeValue
        }
    }
    
    public var projectedValue: Transform.ToType? {
        set { _wrappedValue = newValue }
        get { return _wrappedValue }
    }
    
    public init(default value: Transform.ToType? = nil, key: String? = nil) {
        self._wrappedValue = value
        self.name = key
    }
}

extension SGTransformSerializable {
    internal func getKey(with key: String) -> SGCodingKey {
        let cKey: SGCodingKey
        if let name = name, !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            cKey = SGCodingKey(name: name)
        }else {
            cKey = SGCodingKey(name: key)
        }
        return cKey
    }
}
