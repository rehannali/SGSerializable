//
//  SGSerializable+ProtocolConformance.swift
//  
//
//  Created by Rehan Ali on 16/09/2022.
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
}

extension SGSerializable: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}

