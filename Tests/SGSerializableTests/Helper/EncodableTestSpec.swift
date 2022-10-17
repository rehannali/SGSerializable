//
// EncodableTestSpec.swift
// SGSerializable
// 
// Created by Rehan Ali on 10/10/2022 at 9:47 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 

import Foundation
import Quick
import Nimble

protocol EncodableTestSpec {
    var jsonEncoder: JSONEncoder { get }
    var plistEncoder: PropertyListEncoder { get }
}

extension EncodableTestSpec {
    var jsonEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
    
    var plistEncoder: PropertyListEncoder {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        return encoder
    }
}
