//
//  SGEncoder.swift
//  
//
//  Created by Rehan Ali on 16/09/2022.
//

import Foundation

protocol SGEncoder {
    typealias EncodeContainer = KeyedEncodingContainer<SGCodingKey>
    func encodeValue(from container: inout EncodeContainer, with key: String) throws
}

extension SGSerializable: SGEncoder where Value: Encodable {
    func encodeValue(from container: inout EncodeContainer, with key: String) throws {
        
        try container.encodeIfPresent(wrappedValue, forKey: getKey(with: key))
    }
}
