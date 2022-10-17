//
// DecodableTestSpec.swift
// SGSerializable
// 
// Created by Rehan Ali on 10/10/2022 at 9:53 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation
import Quick
import Nimble

protocol DecodableTestSpec {
    var jsonDecoder: JSONDecoder { get }
    var plistDecoder: PropertyListDecoder { get }
}

extension DecodableTestSpec {
    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    var plistDecoder: PropertyListDecoder {
        let decoder = PropertyListDecoder()
        return decoder
    }
}
