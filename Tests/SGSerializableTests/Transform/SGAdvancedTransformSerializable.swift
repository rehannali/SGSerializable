//
// SGAdvancedTransformSerializable.swift
// SGSerializable
// 
// Created by Rehan Ali on 17/10/2022 at 2:08 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation
import Quick
import Nimble
import SGSerializable

class SGAdvancedTransformSerializable: QuickSpec, EncodableTestSpec, DecodableTestSpec {
    override func spec() {
        describe("SG Advanced Transformation") {
            context("Encoded Data") {
                var object: Base64Encoded?
                it("should access default value before [En/De]Coding") {
                    object = Base64Encoded()
                    expect(object).toNot(beNil())
                    expect(object?.encoded).to(equal("".data(using: .utf8)))
                    expect(object?.$encoded).to(equal("".data(using: .utf8)!))
                }
                
                it("should decode properly using Default") {
                    object = try? self.jsonDecoder.decode(Base64Encoded.self, from: jsonData)
                    
                    expect(object).toNot(beNil())
                    expect(object?.encoded).to(equal("Hi! there. I'm happy to see you.".data(using: .utf8)))
                    expect(object?.$encoded).to(equal("Hi! there. I'm happy to see you.".data(using: .utf8)!))
                }
                
                it("should decode properly using custom") {
                    object = try? Base64Encoded.initialize(with: jsonData)
                    
                    expect(object).toNot(beNil())
                    expect(object?.encoded).to(equal("Hi! there. I'm happy to see you.".data(using: .utf8)))
                    expect(object?.$encoded).to(equal("Hi! there. I'm happy to see you.".data(using: .utf8)!))
                }
                
                it("should encode propery using default") {
                    object = try? Base64Encoded.initialize(with: jsonData)
                    let data = try? self.jsonEncoder.encode(object)
                    
                    guard let data , let string = String(data: data, encoding: .utf8) else {
                        fail("Unable to get valid string")
                        return
                    }
                    
                    let dict = try? JSONSerializer.toDictionary(string).swiftDictionary
                    expect(dict).toNot(beNil())
                    expect(dict?["base64Encoded"] as? String).to(equal("SGkhIHRoZXJlLiBJJ20gaGFwcHkgdG8gc2VlIHlvdS4="))
                }
                
                it("should encode propery using custom") {
                    object = try? Base64Encoded.initialize(with: jsonData)
                    
                    let dict = object?.dictionary
                    expect(dict).toNot(beNil())
                    expect(dict?["base64Encoded"] as? String).to(equal("SGkhIHRoZXJlLiBJJ20gaGFwcHkgdG8gc2VlIHlvdS4="))
                }
            }
            
            context("URL") {
                var object: StringURL?
                it("should decode properly using Default") {
                    object = try? self.jsonDecoder.decode(StringURL.self, from: jsonData)
                    
                    expect(object).toNot(beNil())
                    expect(object?.url).to(equal(URL(string: "https://www.apple.com")))
                    expect(object?.$url).to(equal(URL(string: "https://www.apple.com")!))
                }
                
                it("should decode properly using custom") {
                    object = try? StringURL.initialize(with: jsonData)
                    
                    expect(object).toNot(beNil())
                    expect(object?.url).to(equal(URL(string: "https://www.apple.com")))
                    expect(object?.$url).to(equal(URL(string: "https://www.apple.com")!))
                }
                
                it("should encode propery using default") {
                    object = try? StringURL.initialize(with: jsonData)
                    let data = try? self.jsonEncoder.encode(object)
                    
                    guard let data , let string = String(data: data, encoding: .utf8) else {
                        fail("Unable to get valid string")
                        return
                    }
                    
                    let dict = try? JSONSerializer.toDictionary(string).swiftDictionary
                    expect(dict).toNot(beNil())
                    expect(dict?["url"] as? String).to(equal("https://www.apple.com"))
                }
                
                it("should encode propery using custom") {
                    object = try? StringURL.initialize(with: jsonData)
                    
                    let dict = object?.dictionary
                    expect(dict).toNot(beNil())
                    expect(dict?["url"] as? String).to(equal("https://www.apple.com"))
                }
            }
            
            context("RFC Date") {
                var object: RFCDate?
                it("should access default value before [En/De]Coding") {
                    object = RFCDate()
                    expect(object).toNot(beNil())
                    expect(object?.date).to(beNil())
                    expect(object?.$date).to(equal(Date(timeIntervalSince1970: 0)))
                }
                
                it("should decode properly using Default") {
                    object = try? self.jsonDecoder.decode(RFCDate.self, from: jsonData)
                    
                    let calendar = Calendar.current
                    let actualDate = calendar.date(from: .init(timeZone: .init(secondsFromGMT: 0), year: 2021, month: 9, day: 12, hour: 23, minute: 43, second: 33))
                    
                    expect(object).toNot(beNil())
                    expect(object?.date).to(equal(actualDate))
                    expect(object?.$date).to(equal(actualDate!))
                }
                
                it("should decode properly using custom") {
                    object = try? RFCDate.initialize(with: jsonData)
                    
                    let calendar = Calendar.current
                    let actualDate = calendar.date(from: .init(timeZone: .init(secondsFromGMT: 0), year: 2021, month: 9, day: 12, hour: 23, minute: 43, second: 33))
                    
                    expect(object).toNot(beNil())
                    expect(object?.date).to(equal(actualDate))
                    expect(object?.$date).to(equal(actualDate!))
                }
                
                it("should encode propery using default") {
                    object = try? RFCDate.initialize(with: jsonData)
                    let data = try? self.jsonEncoder.encode(object)
                    
                    guard let data , let string = String(data: data, encoding: .utf8) else {
                        fail("Unable to get valid string")
                        return
                    }
                    
                    let dict = try? JSONSerializer.toDictionary(string).swiftDictionary
                    expect(dict).toNot(beNil())
                    expect(dict?["datetime"] as? String).to(equal("2021-09-12T23:43:33+0000"))
                }
                
                it("should encode propery using custom") {
                    object = try? RFCDate.initialize(with: jsonData)
                    
                    let dict = object?.dictionary
                    expect(dict).toNot(beNil())
                    expect(dict?["datetime"] as? String).to(equal("2021-09-12T23:43:33+0000"))
                }
            }
            
            context("ISO Date") {
                var object: ISODate?
                it("should access default value before [En/De]Coding") {
                    object = ISODate()
                    expect(object).toNot(beNil())
                    expect(object?.date).to(beNil())
                    expect(object?.$date).to(equal(Date(timeIntervalSince1970: 0)))
                }
                
                it("should decode properly using Default") {
                    object = try? self.jsonDecoder.decode(ISODate.self, from: jsonData)
                    
                    let calendar = Calendar.current
                    let actualDate = calendar.date(from: .init(timeZone: .init(secondsFromGMT: 0), year: 2021, month: 9, day: 12, hour: 23, minute: 43, second: 33))
                    
                    expect(object).toNot(beNil())
                    expect(object?.date).to(equal(actualDate))
                    expect(object?.$date).to(equal(actualDate!))
                }
                
                it("should decode properly using custom") {
                    object = try? ISODate.initialize(with: jsonData)
                    
                    let calendar = Calendar.current
                    let actualDate = calendar.date(from: .init(timeZone: .init(secondsFromGMT: 0), year: 2021, month: 9, day: 12, hour: 23, minute: 43, second: 33))
                    
                    expect(object).toNot(beNil())
                    expect(object?.date).to(equal(actualDate))
                    expect(object?.$date).to(equal(actualDate!))
                }
                
                it("should encode propery using default") {
                    object = try? ISODate.initialize(with: jsonData)
                    let data = try? self.jsonEncoder.encode(object)
                    
                    guard let data , let string = String(data: data, encoding: .utf8) else {
                        fail("Unable to get valid string")
                        return
                    }
                    
                    let dict = try? JSONSerializer.toDictionary(string).swiftDictionary
                    expect(dict).toNot(beNil())
                    expect(dict?["datetime"] as? String).to(equal("2021-09-12T23:43:33Z"))
                }
                
                it("should encode propery using custom") {
                    object = try? ISODate.initialize(with: jsonData)
                    
                    let dict = object?.dictionary
                    expect(dict).toNot(beNil())
                    expect(dict?["datetime"] as? String).to(equal("2021-09-12T23:43:33Z"))
                }
            }
            
            context("TimeInterval Date") {
                var object: TimeIntervalDate?
                it("should access default value before [En/De]Coding") {
                    object = TimeIntervalDate()
                    expect(object).toNot(beNil())
                    expect(object?.date).to(beNil())
                    expect(object?.$date).to(equal(Date(timeIntervalSince1970: 0)))
                }
                
                it("should decode properly using Default") {
                    object = try? self.jsonDecoder.decode(TimeIntervalDate.self, from: jsonData)
                    
                    let calendar = Calendar.current
                    let actualDate = calendar.date(from: .init(timeZone: .init(secondsFromGMT: 0), year: 2010, month: 1, day: 9, hour: 3, minute: 37, second: 15))
                    
                    expect(object).toNot(beNil())
                    expect(object?.date).to(equal(actualDate))
                    expect(object?.$date).to(equal(actualDate!))
                }
                
                it("should decode properly using custom") {
                    object = try? TimeIntervalDate.initialize(with: jsonData)
                    
                    let calendar = Calendar.current
                    let actualDate = calendar.date(from: .init(timeZone: .init(secondsFromGMT: 0), year: 2010, month: 1, day: 9, hour: 3, minute: 37, second: 15))
                    
                    expect(object).toNot(beNil())
                    expect(object?.date).to(equal(actualDate))
                    expect(object?.$date).to(equal(actualDate!))
                }
                
                it("should encode propery using default") {
                    object = try? TimeIntervalDate.initialize(with: jsonData)
                    let data = try? self.jsonEncoder.encode(object)
                    
                    guard let data , let string = String(data: data, encoding: .utf8) else {
                        fail("Unable to get valid string")
                        return
                    }
                    
                    let dict = try? JSONSerializer.toDictionary(string).swiftDictionary
                    expect(dict).toNot(beNil())
                    expect(dict?["time"] as? TimeInterval).to(equal(1263008235))
                }
                
                it("should encode propery using custom") {
                    object = try? TimeIntervalDate.initialize(with: jsonData)
                    
                    let dict = object?.dictionary
                    expect(dict).toNot(beNil())
                    expect(dict?["time"] as? TimeInterval).to(equal(1263008235))
                }
            }
        }
    }
}

fileprivate let jsonData = """
{
    "base64Encoded": "SGkhIHRoZXJlLiBJJ20gaGFwcHkgdG8gc2VlIHlvdS4=",
    "url": "https://www.apple.com",
    "datetime": "2021-09-12T23:43:33Z",
    "time": 1263008235
}
""".data(using: .utf8)!

fileprivate struct Base64Encoded: SGCodable {
    @SGTransformSerializable<StringToBase64Data>(default: "".data(using: .utf8) , key: "base64Encoded")
    var encoded: Data?
}

fileprivate struct ISODate: SGCodable {
    @SGTransformSerializable<StringToDateISO8601>(key: "datetime")
    var date: Date?
}

fileprivate struct RFCDate: SGCodable {
    @SGTransformSerializable<StringToDateRFC3339>(key: "datetime")
    var date: Date?
}

fileprivate struct TimeIntervalDate: SGCodable {
    @SGTransformSerializable<TimeIntervalToDate>(key: "time")
    var date: Date?
}

fileprivate struct StringURL: SGCodable {
    @SGTransformSerializable<StringToURL>
    var url: URL?
}
