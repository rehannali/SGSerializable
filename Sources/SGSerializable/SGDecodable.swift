//
//  SGDecodable.swift
//  
//
//  Created by Rehan Ali on 16/09/2022.
//

import Foundation

public protocol SGDecodable: Decodable {
    init()
    static func initialize(data: Data) throws -> Self
    static func initialize<T: SGDecodable>(data: Data, type: T.Type) throws -> T
    static func initialize(with json: String, encoding: String.Encoding) throws -> Self
    static func initialize(fromURL url: URL) throws -> Self
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

