//
// SGEncodable.swift
// SGSerializable
//
// Created by Rehan Ali on 06/10/2022 at 7:57 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

public protocol SGEncodable: Encodable {
    var dictionary: [String: Any] { get }
    func jsonData() throws -> Data
    func jsonString(encoding: String.Encoding) throws -> String?
}

extension SGEncodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SGCodingKey.self)
        
        var mirror: Mirror? = Mirror(reflecting: self)
        
        repeat {
            
            guard let children = mirror?.children else { break }
            
            for child in children {
                guard let encodableValue = child.value as? SGEncoder,
                      var key = child.label else { continue }
                
                if key.hasPrefix("_") {
                    key.remove(at: key.startIndex)
                }
                
                try encodableValue.encodeValue(from: &container, with: key)
            }
            
            mirror = mirror?.superclassMirror
        } while mirror != nil
    }
}

