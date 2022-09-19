//
//  SGDecoder.swift
//  
//
//  Created by Rehan Ali on 16/09/2022.
//

import Foundation

protocol SGDecoder {
    typealias DecodeContainer = KeyedDecodingContainer<SGCodingKey>
    func decodeValue(from container: DecodeContainer, with key: String) throws
}

extension SGSerializable: SGDecoder where Value: Decodable {
    internal func decodeValue(from container: DecodeContainer, with key: String) throws {
        switch Value.self {
            case is Int.Type: try decodeInt(from: container, with: key)
            case is Double.Type: try decodeDouble(from: container, with: key)
            case is Float.Type: try decodeFloat(from: container, with: key)
            case is Bool.Type: try decodeBool(from: container, with: key)
            case is String.Type: try decodeString(from: container, with: key)
            default:
                if let value = try container.decodeIfPresent(Value.self, forKey: getKey(with: key)) {
                    wrappedValue = value
                }
        }
    }
}

extension SGSerializable {
    func decodeInt(from container: DecodeContainer, with key: String) throws {
        if let int = try? container.decodeIfPresent(Int.self, forKey: getKey(with: key)) {
            wrappedValue = int as! Value
        }else if let string = try? container.decodeIfPresent(String.self, forKey: getKey(with: key)), let int = Int(string) {
            wrappedValue = int as! Value
        }else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Invalid \(Value.self) Value"))
        }
    }
    
    func decodeDouble(from container: DecodeContainer, with key: String) throws {
        if let double = try? container.decodeIfPresent(Double.self, forKey: getKey(with: key)) {
            wrappedValue = double as! Value
        }else if let string = try? container.decodeIfPresent(String.self, forKey: getKey(with: key)), let double = Double(string) {
            wrappedValue = double as! Value
        }else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Invalid \(Value.self) Value"))
        }
    }
    
    func decodeFloat(from container: DecodeContainer, with key: String) throws {
        if let float = try? container.decodeIfPresent(Float.self, forKey: getKey(with: key)) {
            wrappedValue = float as! Value
        }else if let string = try? container.decodeIfPresent(String.self, forKey: getKey(with: key)), let float = Float(string) {
            wrappedValue = float as! Value
        }else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Invalid \(Value.self) Value"))
        }
    }
    
    func decodeBool(from container: DecodeContainer, with key: String) throws {
        if let bool = try? container.decodeIfPresent(Bool.self, forKey: getKey(with: key)) {
            wrappedValue = bool as! Value
        }else if let string = try? container.decodeIfPresent(String.self, forKey: getKey(with: key)), let bool = Bool(string) {
            wrappedValue = bool as! Value
        }else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Invalid \(Value.self) Value"))
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
        }else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Invalid \(Value.self) Value"))
        }
    }
}
