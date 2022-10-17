//
// SGCodable.swift
// SGSerializable
// 
// Created by Rehan Ali on 07/10/2022 at 7:59 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation

var newJSONDecoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}

var newJSONEncoder: JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}

public enum SGCodingType {
    case int, double, float, bool, string, auto, none
}

public typealias SGCodable = SGEncodable & SGDecodable

extension SGDecodable {
        /// Initialize any class/struct conform from `SGDecodable`
        /// - Parameter data: JSON data
        /// - Returns: `SGCodable` object returns itself.
    public static func initialize(with data: Data) throws -> Self {
        return try initialize(with: data, type: self)
    }
    
        /// Initialize any class/struct conform from `SGDecodable`
        /// - Parameters:
        ///   - data: JSON data
        ///   - type: Any object conform to `SGDecodable`
        /// - Returns: `SGDecodable` object returns itself.
    public static func initialize<T: SGDecodable>(with data: Data, type: T.Type) throws -> T {
        return try newJSONDecoder.decode(type, from: data)
    }
    
        /// Initialize any class/struct conform from `SGDecodable`
        /// - Parameters:
        ///   - json: JSON string
        ///   - encoding: String Encoding Type while converting string into `Data`
        /// - Returns: `SGDecodable` object returns itself.
    public static func initialize(with json: String, encoding: String.Encoding = .utf8) throws -> Self {
        guard let data = json.data(using: encoding) else {
            throw SGError.jsonCorrupted
        }
        return try initialize(with: data)
    }
    
        /// Initialize any class/struct conform from `SGDecodable`
        /// - Parameter url: Valid URL which returns actual JSON Data.
        /// - Returns: `SGDecodable` object returns itself.
    public static func initialize(from url: URL) throws -> Self {
        return try initialize(with: try Data(contentsOf: url))
    }
}

extension SGEncodable {
        /// Get swift dictionary from any `SGEncodable` object.
    public var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: jsonData())) as? [String: Any] ?? [:]
    }
    
        /// Get JSON data from any `SGEncodable` object.
        /// - Returns: JSON data from any `SGEncodable` object.
    public func jsonData() throws -> Data {
        return try newJSONEncoder.encode(self)
    }
    
        /// Get JSON string from any `SGEncodable` object.
        /// - Parameter encoding: String encoding type like `.utf8`. Default: `.utf8`
        /// - Returns: JSON `String`, or `nil` from any `SGEncodable` object.
    public func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

