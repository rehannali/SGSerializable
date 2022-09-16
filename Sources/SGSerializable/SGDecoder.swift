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
        
        if Value.self is Int.Type {
            if let int = try? container.decodeIfPresent(Int.self, forKey: getKey(with: key)) {
                wrappedValue = int as! Value
            }else if let string = try? container.decodeIfPresent(String.self, forKey: getKey(with: key)), let int = Int(string) {
                wrappedValue = int as! Value
            }else {
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Invalid \(Value.self) Value"))
            }
        }else if let value = try container.decodeIfPresent(Value.self, forKey: getKey(with: key)) {
            wrappedValue = value
        }else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Invalid \(Value.self) Value"))
        }
    }
}

