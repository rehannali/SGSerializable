//
// SGTransformDecoder.swift
// SGSerializable
//
// Created by Rehan Ali on 09/10/2022 at 7:53 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

extension SGTransformSerializable: SGDecoder where Transform.FromType: Decodable {
    func decodeValue(from container: DecodeContainer, with key: String) throws {
        let value = try container.decodeIfPresent(Transform.FromType.self, forKey: getKey(with: key))
        _wrappedValue = Transform.transform(from: value)
    }
}
