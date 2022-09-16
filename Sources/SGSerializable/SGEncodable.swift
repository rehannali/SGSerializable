//
//  SGEncodable.swift
//  
//
//  Created by Rehan Ali on 16/09/2022.
//

import Foundation

public protocol SGEncodable: Encodable {}

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
        }while mirror != nil
    }
}

