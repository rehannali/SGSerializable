//
// SGDecoder.swift
// SGSerializable
//
// Created by Rehan Ali on 05/10/2022 at 7:57 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//


import Foundation
#if canImport(UIKit)
import UIKit
#endif

protocol SGDecoder {
    typealias DecodeContainer = KeyedDecodingContainer<SGCodingKey>
    func decodeValue(from container: DecodeContainer, with key: String) throws
}

extension SGSerializable: SGDecoder where Value: Decodable {
    internal func decodeValue(from container: DecodeContainer, with key: String) throws {
        switch type {
            case .int: try decodeInt(from: container, with: key)
            case .double: try decodeDouble(from: container, with: key)
            case .bool: try decodeBool(from: container, with: key)
            case .float: try decodeFloat(from: container, with: key)
            case .string: try decodeString(from: container, with: key)
            case .auto: try decodeAuto(from: container, with: key)
            case .none:
                if let value = try? container.decodeIfPresent(Value.self, forKey: getKey(with: key)) {
                    wrappedValue = value
                }
        }
    }
    
    private func decodeAuto(from container: DecodeContainer, with key: String) throws {
        switch Value.self {
            case is Int.Type, is Int?.Type: try decodeInt(from: container, with: key)
            case is Double.Type, is Double?.Type: try decodeDouble(from: container, with: key)
            case is Float.Type, is Float?.Type: try decodeFloat(from: container, with: key)
            case is Bool.Type, is Bool?.Type: try decodeBool(from: container, with: key)
            case is String.Type, is String?.Type: try decodeString(from: container, with: key)
            case is Array<Any>?.Type, is Array<Any>.Type:
                try decodeArray(from: container, with: key)
            case is Array<String>?.Type, is Array<String>.Type:
                try decodeArray(from: container, with: key)
            case is Array<Int>?.Type, is Array<Int>.Type:
                try decodeArray(from: container, with: key)
            case is Array<UInt>?.Type, is Array<UInt>.Type:
                try decodeArray(from: container, with: key)
            case is Array<Double>?.Type, is Array<Double>.Type:
                try decodeArray(from: container, with: key)
            case is Dictionary<String, Any>?.Type, is Dictionary<String, Any>.Type:
                try decodeDictionary(from: container, with: key)
            case is Dictionary<String, String>?.Type, is Dictionary<String, String>.Type:
                try decodeDictionary(from: container, with: key)
            case is Dictionary<String, Int>?.Type, is Dictionary<String, Int>.Type:
                try decodeDictionary(from: container, with: key)
            case is Dictionary<String, UInt>?.Type, is Dictionary<String, UInt>.Type:
                try decodeDictionary(from: container, with: key)
            case is Dictionary<String, Double>?.Type, is Dictionary<String, Double>.Type:
                try decodeDictionary(from: container, with: key)
            default:
                if let value = try? container.decodeIfPresent(Value.self, forKey: getKey(with: key)) {
                    wrappedValue = value
                }
        }
    }
}

extension SGSerializable {
    func decodeArray(from container: DecodeContainer, with key: String) throws {
        if let array = try? container.decodeIfPresent(Array<Any>.self, forKey: getKey(with: key)) {
            switch Value.self {
                case is Array<String>?.Type, is Array<String>.Type:
                    downCastValues(String.self, with: array)
                case is Array<Int>?.Type, is Array<Int>.Type:
                    downCastValues(Int.self, with: array)
                case is Array<UInt>?.Type, is Array<UInt>.Type:
                    downCastValues(UInt.self, with: array)
                case is Array<Double>?.Type, is Array<Double>.Type:
                    downCastValues(Double.self, with: array)
                default: projectedValue = array as? Value
            }
        }
    }
    
    func decodeDictionary(from container: DecodeContainer, with key: String) throws {
        if let dict = try? container.decodeIfPresent(Dictionary<String, Any>.self, forKey: getKey(with: key)) {
            switch Value.self {
                case is Dictionary<String, String>?.Type, is Dictionary<String, String>.Type:
                    downCastValues(String.self, with: dict)
                case is Dictionary<String, Int>?.Type, is Dictionary<String, Int>.Type:
                    downCastValues(Int.self, with: dict)
                case is Dictionary<String, UInt>?.Type, is Dictionary<String, UInt>.Type:
                    downCastValues(UInt.self, with: dict)
                case is Dictionary<String, UInt>?.Type, is Dictionary<String, UInt>.Type:
                    downCastValues(UInt.self, with: dict)
                case is Dictionary<String, Double>?.Type, is Dictionary<String, Double>.Type:
                    downCastValues(Double.self, with: dict)
                default: projectedValue = dict as? Value
            }
        }
    }
    
    func decodeInt(from container: DecodeContainer, with key: String) throws {
        if let int = try? container.decodeIfPresent(Int.self, forKey: getKey(with: key)) {
            wrappedValue = int as! Value
        }else if let string = try? container.decodeIfPresent(String.self, forKey: getKey(with: key)), let int = Int(string) {
            wrappedValue = int as! Value
        }
    }
    
    func decodeDouble(from container: DecodeContainer, with key: String) throws {
        if let double = try? container.decodeIfPresent(Double.self, forKey: getKey(with: key)) {
            wrappedValue = double as! Value
        }else if let string = try? container.decodeIfPresent(String.self, forKey: getKey(with: key)), let double = Double(string) {
            wrappedValue = double as! Value
        }
    }
    
    func decodeFloat(from container: DecodeContainer, with key: String) throws {
        if let float = try? container.decodeIfPresent(Float.self, forKey: getKey(with: key)) {
            wrappedValue = float as! Value
        }else if let string = try? container.decodeIfPresent(String.self, forKey: getKey(with: key)), let float = Float(string) {
            wrappedValue = float as! Value
        }
    }
    
    func decodeBool(from container: DecodeContainer, with key: String) throws {
        if let bool = try? container.decodeIfPresent(Bool.self, forKey: getKey(with: key)) {
            wrappedValue = bool as! Value
        }else if let string = try? container.decodeIfPresent(String.self, forKey: getKey(with: key)), let bool = Bool(string) {
            wrappedValue = bool as! Value
        }
    }
    
    func decodeString(from container: DecodeContainer, with key: String) throws {
        if let int = try? container.decodeIfPresent(Int.self, forKey: getKey(with: key)) {
            wrappedValue = String(int) as! Value
        }else if let double = try? container.decodeIfPresent(Double.self, forKey: getKey(with: key)) {
            wrappedValue = String(double) as! Value
        }else if let float = try? container.decodeIfPresent(Float.self, forKey: getKey(with: key)) {
            wrappedValue = String(float) as! Value
        }else if let bool = try? container.decodeIfPresent(Bool.self, forKey: getKey(with: key)) {
            wrappedValue = String(bool) as! Value
        }else if let string = try? container.decodeIfPresent(String.self, forKey: getKey(with: key)) {
            wrappedValue = string as! Value
        }
    }
    
    fileprivate func downCastValues<T>(_ type: T.Type, with array: Array<Any>) {
        var result = Array<T>()
        
        for value in array {
            switch type {
                case is String.Type, is String?.Type:
                    if let int = value as? Int {
                        result.append((String(int) as! T))
                    }else if let double = value as? Double {
                        result.append((String(double) as! T))
                    }else if let bool = value as? Bool {
                        result.append((String(bool) as! T))
                    }else if let string = value as? String {
                        result.append((string as! T))
                    }
                case is Int.Type, is Int?.Type:
                    if let string = value as? String {
                        result.append((Int(string) as! T))
                    } else if let int = value as? Int {
                        result.append((int as! T))
                    }
                case is UInt.Type, is UInt?.Type:
                    if let string = value as? String {
                        result.append((UInt(string) as! T))
                    } else if let int = value as? UInt {
                        result.append((int as! T))
                    }
                case is Double.Type, is Double?.Type:
                    if let string = value as? String {
                        result.append((Double(string) as! T))
                    } else if let double = value as? Double {
                        result.append((double as! T))
                    }
                case is Bool.Type, is Bool?.Type:
                    if let string = value as? String {
                        result.append((Bool(string) as! T))
                    } else if let bool = value as? Bool {
                        result.append((bool as! T))
                    }
                default:
                    if let value = value as? T {
                        result.append(value)
                    }
            }
        }
        
        projectedValue = result as? Value
    }
    
    fileprivate func downCastValues<T>(_ type: T.Type, with dict: Dictionary<String, Any>) {
        var result = Dictionary<String, T>()
        for key in dict.keys {
            switch type {
                case is String.Type, is String?.Type:
                    if let int = dict[key] as? Int {
                        result[key] = (String(int) as! T)
                    }else if let double = dict[key] as? Double {
                        result[key] = (String(double) as! T)
                    }else if let bool = dict[key] as? Bool {
                        result[key] = (String(bool) as! T)
                    }else if let string = dict[key] as? String {
                        result[key] = (string as! T)
                    }
                case is Int.Type, is Int?.Type:
                    if let string = dict[key] as? String {
                        result[key] = (Int(string) as! T)
                    } else if let int = dict[key] as? Int {
                        result[key] = (int as! T)
                    }
                case is UInt.Type, is UInt?.Type:
                    if let string = dict[key] as? String {
                        result[key] = (UInt(string) as! T)
                    } else if let int = dict[key] as? UInt {
                        result[key] = (int as! T)
                    }
                case is Double.Type, is Double?.Type:
                    if let string = dict[key] as? String {
                        result[key] = (Double(string) as! T)
                    } else if let double = dict[key] as? Double {
                        result[key] = (double as! T)
                    }
                case is Bool.Type, is Bool?.Type:
                    if let string = dict[key] as? String {
                        result[key] = (Bool(string) as! T)
                    } else if let bool = dict[key] as? Bool {
                        result[key] = (bool as! T)
                    }
                default:
                    if let value = dict[key] as? T {
                        result[key] = value
                    }
            }
        }
        
        projectedValue = result as? Value
    }
}
