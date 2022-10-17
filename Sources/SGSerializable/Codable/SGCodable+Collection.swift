//
// SGCodable+Collection.swift
// SGSerializable
//
// Created by Rehan Ali on 04/10/2022 at 7:57 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

public extension Array where Element: SGCodable {
        /// Initialize any class/struct conform from `SGDecodable`
        /// - Parameter data: JSON data
        /// - Returns: `SGCodable` object returns itself.
    static func initialize(with data: Data) throws -> [Element] {
        return try initialize(with: data, type: [Element].self)
    }
    
        /// Initialize any class/struct conform from `SGDecodable`
        /// - Parameters:
        ///   - data: JSON data
        ///   - type: Any object conform to `SGDecodable`
        /// - Returns: `SGDecodable` object returns itself.
    static func initialize<T: SGDecodable>(with data: Data, type: [T].Type) throws -> [T] {
        return try newJSONDecoder.decode(type, from: data)
    }
    
    
        /// Initialize any class/struct conform from `SGDecodable`
        /// - Parameters:
        ///   - json: JSON string
        ///   - encoding: String Encoding Type while converting string into `Data`
        /// - Returns: `SGDecodable` object returns itself.
    static func initialize(with json: String, encoding: String.Encoding = .utf8) throws -> [Element] {
        guard let data = json.data(using: encoding) else {
            throw SGError.jsonCorrupted
        }
        return try initialize(with: data)
    }
    
        /// Initialize any class/struct conform from `SGDecodable`
        /// - Parameter url: Valid URL which returns actual JSON Data.
        /// - Returns: `SGDecodable` object returns itself.
    static func initialize(fromURL url: URL) throws -> [Element] {
        return try initialize(with: try Data(contentsOf: url))
    }
    
        /// Get JSON data from any `SGEncodable` object.
        /// - Returns: JSON data from any `SGEncodable` object.
    func jsonData() throws -> Data {
        return try newJSONEncoder.encode(self)
    }
    
        /// Get JSON string from any `SGEncodable` object.
        /// - Parameter encoding: String encoding type like `.utf8`. Default: `.utf8`
        /// - Returns: JSON `String`, or `nil` from any `SGEncodable` object.
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}
