//
// SGAdvancedDecodableSpec.swift
// SGSerializable
// 
// Created by Rehan Ali on 12/10/2022 at 2:36 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation
import Quick
import Nimble
import SGSerializable

final class SGAdvancedDecodableSpec: QuickSpec, DecodableTestSpec {
    override func spec() {
        describe("SG Advanced Decodable") {
            context("should access default value before [En/De]Coding") {
                var object: TestData?
                it("should give default values") {
                    object = TestData()
                    
                    expect(object).toNot(beNil())
                    expect(object?.items).to(equal([]))
                    expect(object?.cryptography).to(equal([:]))
                    expect(object?.values).to(equal([]))
                }
            }
            
            context("Value Count") {
                it("should return count after decoding using default") {
                    let object = try? self.jsonDecoder.decode(TestData.self, from: jsonData)
                    
                    expect(object).toNot(beNil())
                    expect(object?.items.count).to(equal(3))
                    expect(object?.cryptography.count).to(equal(2))
                    expect(object?.values?.count).to(equal(0))
                }
                
                it("should return count after decoding using custom") {
                    let object = try? TestData.initialize(with: jsonData)
                    
                    expect(object).toNot(beNil())
                    expect(object?.items.count).to(equal(3))
                    expect(object?.values?.count).to(equal(0))
                }
            }
            
            context("value Comparision") {
                var object: TestData?
                beforeEach {
                    object = try? TestData.initialize(with: jsonData)
                }
                
                it("Plain") {
                    expect(object).toNot(beNil())
                    expect(object?.key).to(equal("Basic"))
                }
                
                it("Array") {
                    expect(object).toNot(beNil())
                    expect(object?.items[0]).to(equal("Coke"))
                    expect(object?.items[1]).to(equal("Code Red"))
                    expect(object?.items[2]).to(equal("Marinda Citrus"))
                }
                
                it("Dictionary") {
                    expect(object).toNot(beNil())
                    expect(object?.cryptography["type"]).to(equal("AES"))
                    expect(object?.cryptography["value"]).to(equal("512"))
                }
                
                it("Mismatch") {
                    expect(object).toNot(beNil())
                    expect(object?.values).to(equal([]))
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

fileprivate struct TestData: SGDecodable {
    @SGSerializable
    var key: String?
    
    @SGSerializable(default: [])
    var items: [String]
    
    @SGSerializable(key: "crypto")
    var cryptography: [String: String]
    
    @SGSerializable
    var values: [Double]?
}
