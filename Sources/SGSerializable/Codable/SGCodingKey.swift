//
// SGCodingKey.swift
// SGSerializable
//
// Created by Rehan Ali on 04/10/2022 at 7:57 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
//

import Foundation

struct SGCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init(name: String) {
        self.stringValue = name
    }
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}
