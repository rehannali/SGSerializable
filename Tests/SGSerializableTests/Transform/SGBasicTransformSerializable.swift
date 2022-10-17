//
// SGBasicTransformSerializable.swift
// SGSerializable
// 
// Created by Rehan Ali on 13/10/2022 at 8:32 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation
import Quick
import Nimble
import SGSerializable

class SGBasicTransformSerializable: QuickSpec, DecodableTestSpec, EncodableTestSpec {
    override func spec() {
        describe("SG Basic Transform") {
            context("Decode Data") {
                var object: Test?
                it("should decode using default") {
                    object = try? self.jsonDecoder.decode(Test.self, from: jsonData)
                    expect(object).toNot(beNil())
                    expect(object?.num).to(equal("20"))
                    expect(object?.sum).to(equal("60"))
                }
                
                it("should decode using custom") {
                    object = try? Test.initialize(with: jsonData)
                    expect(object).toNot(beNil())
                    expect(object?.num).to(equal("20"))
                    expect(object?.sum).to(equal("60"))
                }
            }
            
            context("Encode Data") {
                var object: Test?
                beforeEach {
                    object = try? Test.initialize(with: jsonData)
                }
                
                it("should encode using default") {
                    let encodeData = try? self.jsonEncoder.encode(object)
                    guard let encodeData, let json = String(data: encodeData, encoding: .utf8) else {
                        fail("Unable to get valid data")
                        return
                    }
                    let dict = try? JSONSerializer.toDictionary(json).swiftDictionary
                    
                    expect(dict).toNot(beNil())
                    expect(dict?["num"] as? Int).to(equal(20))
                    expect(dict?["sum"] as? Int).to(equal(60))
                }
                
                it("should encode using Custom") {
                    let dict = object?.dictionary
                    
                    expect(dict).toNot(beNil())
                    expect(dict?["num"] as? Int).to(equal(20))
                    expect(dict?["sum"] as? Int).to(equal(60))
                }
            }
            
            context("Encode Manual") {
                var object: Test?
                beforeEach {
                    object = Test(
                        num: SGTransformSerializable<IntToString>(default: "30", key: "number"),
                        sum: SGTransformSerializable<IntToString>(default: "40"))
                }
                
                it("should encode using Custom") {
                    let dict = object?.dictionary
                    
                    expect(dict).toNot(beNil())
                    expect(dict?["number"] as? Int).to(equal(30))
                    expect(dict?["sum"] as? Int).to(equal(40))
                }
            }
        }
    }
}

fileprivate let jsonData = """
{
    "num": 20,
    "sum": 60
}
""".data(using: .utf8)!

fileprivate struct Test: SGCodable {
    @SGTransformSerializable<IntToString>(default: "")
    var num: String?
    
    @SGTransformSerializable<IntToString>
    var sum: String?
}


fileprivate struct IntToString: SGTranformable {
    typealias FromType = Int
    typealias ToType = String
    
    static func transform(from value: Int?) -> String? {
        guard let value else { return nil }
        return String(value)
    }

    static func transform(from value: String?) -> Int? {
        guard let value else { return nil }
        return Int(value) ?? 0
    }
}
