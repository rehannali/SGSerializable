//
// SGAdvancedEncodableSpec.swift
// SGSerializable
// 
// Created by Rehan Ali on 13/10/2022 at 7:12 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation
import Quick
import Nimble
import SGSerializable

class SGAdvancedEncodableSpec: QuickSpec, EncodableTestSpec, DecodableTestSpec {
    override func spec() {
        describe("SG Encoder Advanced") {
            var object: TestData?
            beforeEach {
                object = TestData(key: SGSerializable(default: "Basic"), items: SGSerializable(default: [
                    "Code Red",
                    "Marinda Citrus",
                    "Coke",
                    "Lemonade"
                ]), cryptography: SGSerializable(default: [
                    "type": "SHA",
                    "value": "512"
                ], key: "crypto"), values: SGSerializable(default: nil))
            }
            context("Value Count") {
                it("should match actual result ") {
                    expect(object).toNot(beNil())
                    expect(object?.cryptography.count).to(equal(2))
                    expect(object?.items.count).to(equal(4))
                }
            }
            
            context("Basic Value") {
                it("should encode basic value") {
                    let dict = object?.dictionary
                    expect(dict).toNot(beNil())
                    expect(dict?["key"] as? String).to(equal("Basic"))
                }
            }
            
            context("Array Value") {
                var dict: [String: Any]?
                beforeEach {
                    dict = object?.dictionary
                }
                it("should encode array value and get count") {
                    let array = dict?["items"] as? Array<String>
                    expect(dict).toNot(beNil())
                    expect(array).toNot(beNil())
                    
                    expect(array?.count).to(equal(4))
                }
                
                it("should encode and match expected result with actual") {
                    let array = dict?["items"] as? Array<String>
                    expect(dict).toNot(beNil())
                    expect(array).toNot(beNil())
                    
                    expect(array?[0]).to(equal("Code Red"))
                    expect(array?[1]).to(equal("Marinda Citrus"))
                    expect(array?[2]).to(equal("Coke"))
                    expect(array?[3]).to(equal("Lemonade"))
                }
            }
            
            context("Dictionary") {
                var dict: [String: Any]?
                beforeEach {
                    dict = object?.dictionary
                }
                it("should encode array value and get count") {
                    let crypto = dict?["crypto"] as? Dictionary<String, String>
                    expect(dict).toNot(beNil())
                    expect(crypto).toNot(beNil())
                    
                    expect(crypto?.count).to(equal(2))
                }
                
                it("should encode and match expected result with actual") {
                    let crypto = dict?["crypto"] as? Dictionary<String, String>
                    expect(dict).toNot(beNil())
                    expect(crypto).toNot(beNil())
                    
                    expect(crypto?["type"]).to(equal("SHA"))
                    expect(crypto?["value"]).to(equal("512"))
                }
            }
            
            context("Mismatch") {
                var dict: [String: Any]?
                beforeEach {
                    dict = object?.dictionary
                }
                
                it("should get default value") {
                    let array = dict?["values"] as? Array<Double>
                    
                    expect(array).toNot(beNil())
                    expect(array?.count).to(equal(0))
                }
            }
        }
    }
}

fileprivate let jsonData = """
{
    "key": "Basic",
    "items": [
        "Coke",
        "Code Red",
        "Marinda Citrus"
    ],
    "crypto": {
        "type": "AES",
        "value": 512
    },
    "values": "Mismatch"
}
""".data(using: .utf8)!

fileprivate struct TestData: SGCodable {
    @SGSerializable
    var key: String?
    
    @SGSerializable(default: [])
    var items: [String]
    
    @SGSerializable(key: "crypto")
    var cryptography: [String: String]
    
    @SGSerializable
    var values: [Double]?
}
