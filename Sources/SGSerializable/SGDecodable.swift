//
//  SGDecodable.swift
//  
//
//  Created by Rehan Ali on 16/09/2022.
//

import Foundation

public protocol SGDecodable: Decodable {
    init()
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
        }while mirror != nil
    }
}

