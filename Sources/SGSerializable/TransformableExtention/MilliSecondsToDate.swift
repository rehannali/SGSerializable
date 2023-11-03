//
//  MilliSecondsToDate.swift
//  SGSerializable
//
//  Created by Rehan Ali on 02/11/2023 at 12:49 AM.
//  Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

public struct MilliSecondsToDate: SGTranformable {
    public typealias FromType = TimeInterval
    public typealias ToType = Date
    
    public static func transform(from value: TimeInterval?) -> Date? {
        guard let value else { return nil }
        return Date(timeIntervalSince1970: value / 1000)
    }
    
    public static func transform(from value: Date?) -> TimeInterval? {
        guard let value else { return nil }
        return value.timeIntervalSince1970 * 1000
    }
}
