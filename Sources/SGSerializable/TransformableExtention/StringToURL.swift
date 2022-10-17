//
// StringToURL.swift
// SGSerializable
// 
// Created by Rehan Ali on 14/10/2022 at 11:16 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation

public struct StringToURL: SGTranformable {
    public typealias FromType = String
    public typealias ToType = URL
    
    public static func transform(from value: String?) -> URL? {
        guard let value else { return nil }
        return URL(string: value)
    }
    
    public static func transform(from value: URL?) -> String? {
        value?.absoluteString
    }
}
