//
// SGEncoder.swift
// SGSerializable
//
// Created by Rehan Ali on 06/10/2022 at 7:57 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
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
