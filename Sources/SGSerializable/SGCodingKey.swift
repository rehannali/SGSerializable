//
//  SGCodingKey.swift
//  
//
//  Created by Rehan Ali on 16/09/2022.
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
