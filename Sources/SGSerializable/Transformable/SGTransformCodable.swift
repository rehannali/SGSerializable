//
// SGTransformCodable.swift
// SGSerializable
//
// Created by Rehan Ali on 09/10/2022 at 7:54 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

    /// This protocol must conform while implementing custom transformation.
public protocol SGTranformable {
    associatedtype FromType
    associatedtype ToType
    
    static func transform(from value: FromType?) -> ToType?
    static func transform(from value: ToType?) -> FromType?
}
