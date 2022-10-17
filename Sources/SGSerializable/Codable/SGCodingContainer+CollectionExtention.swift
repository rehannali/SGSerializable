//
// SGCodingContainer.swift
// SGSerializable
// 
// Created by Rehan Ali on 12/10/2022 at 4:47 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation

extension KeyedDecodingContainer {
    public func decode(_ type: Array<Any>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Array<Any> {
        var container = try nestedUnkeyedContainer(forKey: key)
        return try container.decode(type)
    }
    
    public func decode(_ type: Dictionary<String, Any>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Dictionary<String, Any> {
        let container = try nestedContainer(keyedBy: SGCodingKey.self, forKey: key)
        return try container.decode(type)
    }
    
    public func decodeIfPresent(_ type: Array<Any>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Array<Any>? {
        guard contains(key), try !decodeNil(forKey: key) else { return nil }
        return try decode(type, forKey: key)
    }
    
    public func decodeIfPresent(_ type: Dictionary<String, Any>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Dictionary<String, Any>? {
        guard contains(key), try !decodeNil(forKey: key) else { return nil }
        return try decode(type, forKey: key)
    }
    
    func decode(_ type: Dictionary<String, Any>.Type) throws -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        for key in allKeys {
            if try decodeNil(forKey: key) {
                dictionary[key.stringValue] = NSNull()
            } else if let bool = try? decode(Bool.self, forKey: key) {
                dictionary[key.stringValue] = bool
            } else if let string = try? decode(String.self, forKey: key) {
                dictionary[key.stringValue] = string
            } else if let int = try? decode(Int.self, forKey: key) {
                dictionary[key.stringValue] = int
            } else if let double = try? decode(Double.self, forKey: key) {
                dictionary[key.stringValue] = double
            } else if let dict = try? decode(Dictionary<String, Any>.self, forKey: key) {
                dictionary[key.stringValue] = dict
            } else if let array = try? decode(Array<Any>.self, forKey: key) {
                dictionary[key.stringValue] = array
            }
        }
        return dictionary
    }
}

extension UnkeyedDecodingContainer {
    mutating func decode(_ type: Array<Any>.Type) throws -> Array<Any> {
        var elements: Array<Any> = []
        while !isAtEnd {
            if try decodeNil() {
                elements.append(NSNull())
            } else if let bool = try? decode(Bool.self) {
                elements.append(bool)
            } else if let string = try? decode(String.self) {
                elements.append(string)
            } else if let int = try? decode(Int.self) {
                elements.append(int)
            } else if let double = try? decode(Double.self) {
                elements.append(double)
            } else if let values = try? nestedContainer(keyedBy: SGCodingKey.self),
                      let element = try? values.decode(Dictionary<String, Any>.self) {
                elements.append(element)
            } else if var values = try? nestedUnkeyedContainer(),
                      let element = try? values.decode(Array<Any>.self) {
                elements.append(element)
            }
        }
        return elements
    }
    
    mutating func decode(_ type: Dictionary<String, Any>.Type) throws -> Dictionary<String, Any> {
        let container = try nestedContainer(keyedBy: SGCodingKey.self)
        return try container.decode(type)
    }
}

extension KeyedEncodingContainer {
    public mutating func encode(_ value: Dictionary<String, Any>, forKey key: KeyedEncodingContainer<K>.Key) throws {
        var container = nestedContainer(keyedBy: SGCodingKey.self, forKey: key)
        try container.encode(value)
    }
    
    public mutating func encode(_ value: Array<Any>, forKey key: KeyedEncodingContainer<K>.Key) throws {
        var container = nestedUnkeyedContainer(forKey: key)
        try container.encode(value)
    }
    
    public mutating func encodeIfPresent(_ value: Dictionary<String, Any>?, forKey key: KeyedEncodingContainer<K>.Key) throws {
        if let value = value {
            var container = nestedContainer(keyedBy: SGCodingKey.self, forKey: key)
            try container.encode(value)
        } else {
            try encodeNil(forKey: key)
        }
    }
    
    public mutating func encodeIfPresent(_ value: Array<Any>?, forKey key: KeyedEncodingContainer<K>.Key) throws {
        if let value = value {
            var container = nestedUnkeyedContainer(forKey: key)
            try container.encode(value)
        } else {
            try encodeNil(forKey: key)
        }
    }
}

extension KeyedEncodingContainer where K == SGCodingKey {
    mutating func encode(_ dict: Dictionary<String, Any>) throws {
        for (key, value) in dict {
            let key = SGCodingKey(name: key)
            switch value {
                case is NSNull:
                    try encodeNil(forKey: key)
                case let bool as Bool:
                    try encode(bool, forKey: key)
                case let string as String:
                    try encode(string, forKey: key)
                case let int as Int:
                    try encode(int, forKey: key)
                case let double as Double:
                    try encode(double, forKey: key)
                case let dict as Dictionary<String, Any>:
                    try encode(dict, forKey: key)
                case let array as Array<Any>:
                    try encode(array, forKey: key)
                default: debugPrint("Unsuported type for now!", value)
            }
        }
    }
}

extension UnkeyedEncodingContainer {
    mutating func encode(_ array: Array<Any>) throws {
        for value in array {
            switch value {
                case is NSNull:
                    try encodeNil()
                case let string as String:
                    try encode(string)
                case let int as Int:
                    try encode(int)
                case let bool as Bool:
                    try encode(bool)
                case let double as Double:
                    try encode(double)
                case let dict as Dictionary<String, Any>:
                    try encode(dict)
                case let array as Array<Any>:
                    var values = nestedUnkeyedContainer()
                    try values.encode(array)
                default: debugPrint("Unsuported type for now!", value)
            }
        }
    }
    
    mutating func encode(_ value: Dictionary<String, Any>) throws {
        var container = nestedContainer(keyedBy: SGCodingKey.self)
        try container.encode(value)
    }
}
