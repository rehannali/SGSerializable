//
// TimeIntervalToDate.swift
// SGSerializable
// 
// Created by Rehan Ali on 15/10/2022 at 12:49 AM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation

public struct TimeIntervalToDate: SGTranformable {
    public typealias FromType = TimeInterval
    public typealias ToType = Date
    
    public static func transform(from value: TimeInterval?) -> Date? {
        guard let value else { return nil }
        return Date(timeIntervalSince1970: value)
    }
    
    public static func transform(from value: Date?) -> TimeInterval? {
        guard let value else { return nil }
        return value.timeIntervalSince1970
    }
}
