//
// SGTransformEncoder.swift
// SGSerializable
//
// Created by Rehan Ali on 09/10/2022 at 7:53 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

extension SGTransformSerializable: SGEncoder where Transform.FromType: Encodable {
    func encodeValue(from container: inout EncodeContainer, with key: String) throws {
        try container.encodeIfPresent(Transform.transform(from: wrappedValue), forKey: getKey(with: key))
    }
}
