//
// StringToDateRFC3339.swift
// SGSerializable
// 
// Created by Rehan Ali on 14/10/2022 at 11:47 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation

public struct StringToDateRFC3339: SGTranformable {
    public typealias FromType = String
    public typealias ToType = Date
    
    private static var formatted: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
    
    public static func transform(from value: String?) -> Date? {
        guard let value = value else { return nil }
        return StringToDateRFC3339.formatted.date(from: value)
    }
    
    public static func transform(from value: Date?) -> String? {
        guard let value = value else { return nil }
        return StringToDateRFC3339.formatted.string(from: value)
    }
}
