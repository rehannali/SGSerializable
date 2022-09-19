//
//  SGCodable.swift
//  
//
//  Created by Rehan Ali on 16/09/2022.
//

import Foundation

public extension Array where Element: SGCodable {
    static func initialize(data: Data) throws -> [Element] {
        return try initialize(data: data, type: [Element].self)
    }
    
    static func initialize<T: SGDecodable>(data: Data, type: [T].Type) throws -> [T] {
        return try newJSONDecoder.decode(type, from: data)
    }
    
    static func initialize(with json: String, encoding: String.Encoding = .utf8) throws -> [Element] {
        guard let data = json.data(using: encoding) else {
            throw SGError.jsonCorrupted
        }
        return try initialize(data: data)
    }
    
    static func initialize(fromURL url: URL) throws -> [Element] {
        return try initialize(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder.encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}
