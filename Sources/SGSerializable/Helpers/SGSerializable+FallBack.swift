//
// SGFallBack.swift
// SGSerializable
//
// Created by Rehan Ali on 07/10/2022 at 7:53 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

extension SGSerializable {
    func getFallBack<Value>(_ type: Value.Type) -> Value {
        switch self.type {
            case .int: return 0 as! Value
            case .double: return 0 as! Value
            case .bool: return false as! Value
            case .float: return 0 as! Value
            case .string: return "" as! Value
            case .auto: return processAuto(Value.self)
            case .none: fatalError("\(Value.self) has been used before initialization.")
        }
    }
}

extension SGTransformSerializable {
    func getFallBack<Value>(_ type: Value.Type) -> Value {
        return processAuto(Value.self)
    }
}

fileprivate func processAuto<Value>(_ type: Value.Type) -> Value {
    switch Value.self {
        case is Int?.Type, is Int.Type: return 0 as! Value
        case is UInt?.Type, is UInt.Type: return 0 as! Value
        #if canImport(UIKit)
        case is CGFloat?.Type, is CGFloat.Type: return 0 as! Value
        case is Array<CGFloat>?.Type, is Array<CGFloat>.Type: return Array<CGFloat>() as! Value
        case is Dictionary<String, CGFloat>?.Type, is Dictionary<String, CGFloat>.Type: return Dictionary<String, CGFloat>() as! Value
        #else
        case is Float?.Type, is Float.Type: return 0 as! Value
        case is Dictionary<String, Float>?.Type, is Dictionary<String, Float>.Type: return Dictionary<String, Float>() as! Value
        case is Array<Float>?.Type, is Array<Float>.Type: return Array<Float>() as! Value
        #endif
        case is Double?.Type, is Double.Type: return 0 as! Value
        case is TimeInterval?.Type, is TimeInterval.Type: return 0 as! Value
        case is Bool?.Type, is Bool.Type: return false as! Value
        case is String?.Type, is String.Type: return "" as! Value
        case is Array<Any>?.Type, is Array<Any>.Type: return Array<Any>() as! Value
        case is Array<String>?.Type, is Array<String>.Type: return Array<String>() as! Value
        case is Array<Int>?.Type, is Array<Int>.Type: return Array<Int>() as! Value
        case is Array<UInt>?.Type, is Array<UInt>.Type: return Array<UInt>() as! Value
        case is Array<Double>?.Type, is Array<Double>.Type: return Array<Double>() as! Value
        case is Dictionary<String, Any>?.Type, is Dictionary<String, Any>.Type: return Dictionary<String, Any>() as! Value
        case is Dictionary<String, String>?.Type, is Dictionary<String, String>.Type: return Dictionary<String, String>() as! Value
        case is Dictionary<String, Int>?.Type, is Dictionary<String, Int>.Type: return Dictionary<String, Int>() as! Value
        case is Dictionary<String, UInt>?.Type, is Dictionary<String, UInt>.Type: return Dictionary<String, UInt>() as! Value
        case is Dictionary<String, Double>?.Type, is Dictionary<String, Double>.Type: return Dictionary<String, Double>() as! Value
        case is Date.Type, is Date?.Type: return Date(timeIntervalSince1970: 0) as! Value
        case is Data.Type, is Data?.Type: return "".data(using: .utf8)! as! Value
        default: fatalError("\(Value.self) has been used before initialization.")
    }
}
