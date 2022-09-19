//
//  SGCodable.swift
//  
//
//  Created by Rehan Ali on 16/09/2022.
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

public typealias SGCodable = SGEncodable & SGDecodable

extension SGDecodable {
    public static func initialize(data: Data) throws -> Self {
        return try initialize(data: data, type: self)
    }
    
    public static func initialize<T: SGDecodable>(data: Data, type: T.Type) throws -> T {
        return try newJSONDecoder.decode(type, from: data)
    }
    
    public static func initialize(with json: String, encoding: String.Encoding = .utf8) throws -> Self {
        guard let data = json.data(using: encoding) else {
            throw SGError.jsonCorrupted
        }
        return try initialize(data: data)
    }
    
    public static func initialize(fromURL url: URL) throws -> Self {
        return try initialize(data: try Data(contentsOf: url))
    }
}

extension SGEncodable {
    public var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: jsonData())) as? [String: Any] ?? [:]
    }
    
    public func jsonData() throws -> Data {
        return try newJSONEncoder.encode(self)
    }
    
    public func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}
