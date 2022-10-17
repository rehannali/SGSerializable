//
// SGDecodable.swift
// SGSerializable
//
// Created by Rehan Ali on 05/10/2022 at 7:57 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

public protocol SGDecodable: Decodable {
    init()
    static func initialize(with data: Data) throws -> Self
    static func initialize<T: SGDecodable>(with data: Data, type: T.Type) throws -> T
    static func initialize(with json: String, encoding: String.Encoding) throws -> Self
    static func initialize(from url: URL) throws -> Self
}

extension SGDecodable {
    public init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: SGCodingKey.self)
        
        var mirror: Mirror? = Mirror(reflecting: self)
        
        repeat {
            
            guard let children = mirror?.children else { break }
            
            for child in children {
                guard let decodableValue = child.value as? SGDecoder,
                      var key = child.label else { continue }
                
                if key.hasPrefix("_") {
                    key.remove(at: key.startIndex)
                }
                
                try decodableValue.decodeValue(from: container, with: key)
            }
            mirror = mirror?.superclassMirror
        } while mirror != nil
    }
}

