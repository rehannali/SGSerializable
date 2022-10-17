//
// SGSerializable+ProtocolConformance.swift
// SGSerializable
//
// Created by Rehan Ali on 07/10/2022 at 7:53 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

extension SGSerializable: Equatable where Value: Equatable {
    public static func == (lhs: SGSerializable<Value>, rhs: SGSerializable<Value>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
    
    public static func == (lhs: Value, rhs: SGSerializable<Value>) -> Bool {
        lhs == rhs.wrappedValue
    }
    
    public static func == (lhs: SGSerializable<Value>, rhs: Value) -> Bool {
        lhs.wrappedValue == rhs
    }
    
    public static func != (lhs: SGSerializable<Value>, rhs: SGSerializable<Value>) -> Bool {
        lhs.wrappedValue != rhs.wrappedValue
    }
    
    public static func != (lhs: Value, rhs: SGSerializable<Value>) -> Bool {
        lhs != rhs.wrappedValue
    }
    
    public static func != (lhs: SGSerializable<Value>, rhs: Value) -> Bool {
        lhs.wrappedValue != rhs
    }
}

extension SGSerializable: Comparable where Value: Comparable {
    public static func < (lhs: SGSerializable<Value>, rhs: SGSerializable<Value>) -> Bool {
        lhs.wrappedValue < rhs.wrappedValue
    }
    
    public static func < (lhs: Value, rhs: SGSerializable<Value>) -> Bool {
        lhs < rhs.wrappedValue
    }
    
    public static func < (lhs: SGSerializable<Value>, rhs: Value) -> Bool {
        lhs.wrappedValue < rhs
    }
    
    public static func > (lhs: SGSerializable<Value>, rhs: SGSerializable<Value>) -> Bool {
        lhs.wrappedValue > rhs.wrappedValue
    }
    
    public static func > (lhs: Value, rhs: SGSerializable<Value>) -> Bool {
        lhs > rhs.wrappedValue
    }
    
    public static func > (lhs: SGSerializable<Value>, rhs: Value) -> Bool {
        lhs.wrappedValue > rhs
    }
    
    public static func <= (lhs: SGSerializable<Value>, rhs: SGSerializable<Value>) -> Bool {
        lhs.wrappedValue <= rhs.wrappedValue
    }
    
    public static func <= (lhs: Value, rhs: SGSerializable<Value>) -> Bool {
        lhs <= rhs.wrappedValue
    }
    
    public static func <= (lhs: SGSerializable<Value>, rhs: Value) -> Bool {
        lhs.wrappedValue <= rhs
    }
    
    public static func >= (lhs: SGSerializable<Value>, rhs: SGSerializable<Value>) -> Bool {
        lhs.wrappedValue >= rhs.wrappedValue
    }
    
    public static func >= (lhs: Value, rhs: SGSerializable<Value>) -> Bool {
        lhs >= rhs.wrappedValue
    }
    
    public static func >= (lhs: SGSerializable<Value>, rhs: Value) -> Bool {
        lhs.wrappedValue >= rhs
    }
}

extension SGSerializable: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}

