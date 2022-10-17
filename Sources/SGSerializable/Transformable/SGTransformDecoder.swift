//
// SGTransformDecoder.swift
// SGSerializable
//
// Created by Rehan Ali on 09/10/2022 at 7:53 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

extension SGTransformSerializable: SGDecoder where Value.FromType: Decodable {
    func decodeValue(from container: DecodeContainer, with key: String) throws {
        if let value = try? container.decodeIfPresent(Value.FromType.self, forKey: getKey(with: key)) {
            wrappedValue = Value.transform(from: value)
        }
    }
}
