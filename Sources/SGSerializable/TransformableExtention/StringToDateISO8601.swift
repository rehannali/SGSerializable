//
// StringToDateISO8601.swift
// SGSerializable
// 
// Created by Rehan Ali on 14/10/2022 at 11:22 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation

public struct StringToDateISO8601: SGTranformable {
    public typealias FromType = String
    public typealias ToType = Date
    
    public static var dateFormatter: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withInternetDateTime
        return formatter
    }
    
    public static func transform(from value: String?) -> Date? {
        guard let value = value else { return nil }
        return StringToDateISO8601.dateFormatter.date(from: value)
    }
    
    public static func transform(from value: Date?) -> String? {
        guard let value = value else { return nil }
        return StringToDateISO8601.dateFormatter.string(from: value)
    }
}
