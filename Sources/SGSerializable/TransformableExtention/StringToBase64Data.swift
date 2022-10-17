//
// StringToBase64Data.swift
// SGSerializable
// 
// Created by Rehan Ali on 14/10/2022 at 11:35 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation

public struct StringToBase64Data: SGTranformable {
    public typealias FromType = String
    public typealias ToType = Data
    
    public static func transform(from value: String?) -> Data? {
        guard let value else { return nil }
        return Data(base64Encoded: value)
    }
    
    public static func transform(from value: Data?) -> String? {
        guard let value else { return nil }
        return value.base64EncodedString()
    }
}
