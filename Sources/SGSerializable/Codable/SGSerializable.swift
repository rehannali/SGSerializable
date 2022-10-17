//
// SGSerializable.swift
// SGSerializable
//
// Created by Rehan Ali on 07/10/2022 at 7:53 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

    /// Used to (De/En)coding of attributes and provide custom key value in `name` if needed.
    ///
    /// You can provide default value as well if needed.
    ///
    /// `SGSerializable(name: "firstName")`
    ///
    /// `var name: String?`
@propertyWrapper
public final class SGSerializable<Value> {
    public var name: String?
    public var type: SGCodingType
    private var _wrappedValue: Value?
    
    public var wrappedValue: Value {
        get {
            guard let safeValue = _wrappedValue else {
                return getFallBack(Value.self)
            }
            return safeValue
        }
        set { _wrappedValue = newValue }
    }
    
    public var projectedValue: Value? {
        get { _wrappedValue }
        set { _wrappedValue = newValue }
    }
    
    public init(default value: Value? = nil, key: String? = nil, type: SGCodingType = .auto) {
        self._wrappedValue = value
        self.name = key
        self.type = type
    }
}

extension SGSerializable {
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
