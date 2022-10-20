//
// SGBasicDecodableSpec.swift
// SGSerializable
// 
// Created by Rehan Ali on 11/10/2022 at 11:18 AM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation
import Quick
import Nimble
import SGSerializable

class SGBasicDecodableSpec: QuickSpec, DecodableTestSpec {
    override func spec() {
        describe("SG basic decoding") {
            context("using default decoder") {
                it("should decode properly") {
                    let person = try? self.jsonDecoder.decode(Person.self, from: jsonData)
                    
                    expect(person).toNot(beNil())
                    expect(person?.age).to(equal(54))
                    expect(person?.name).to(equal("Nadeem"))
                    expect(person?.city).to(equal("Karachi"))
                    expect(person?.omit).to(beNil())
                }
            }
            
            context("using custom decoder") {
                it("should decode properly") {
                    let person = try? Person.initialize(with: jsonData)
                    
                    expect(person).toNot(beNil())
                    expect(person?.age).to(equal(54))
                    expect(person?.name).to(equal("Nadeem"))
                    expect(person?.city).to(equal("Karachi"))
                    expect(person?.omit).to(beNil())
                }
            }
            
            context("should access default value before [En/De]Coding") {
                let person = Person()
                it("should give default value") {
                    expect(person.name).toNot(beNil())
                    expect(person.name).to(equal(""))
                    expect(person.$name).to(beNil())
                    expect(person.omit).to(beNil())
                }
            }
            
            context("inheritance") {
                it("should decode") {
                    let personRole = try? Role.initialize(with: jsonData)
                    
                    expect(personRole).toNot(beNil())
                    expect(personRole?.age).to(equal(54))
                    expect(personRole?.name).to(equal("Nadeem"))
                    expect(personRole?.city).to(equal("Karachi"))
                    expect(personRole?.role).to(equal("admin"))
                    expect(personRole?.omit).to(beNil())
                }
            }
            
            context("composition") {
                var person: Person?
                it("should get default before initialization") {
                    person = Person()
                    expect(person?.animmal).toNot(beNil())
                    expect(person?.animmal?.name).toNot(beNil())
                    expect(person?.animmal?.name).to(equal(""))
                    expect(person?.omit).to(beNil())
                }
                
                it("should decode properly") {
                    person = try? Person.initialize(with: jsonData)
                    
                    expect(person).toNot(beNil())
                    expect(person?.age).to(equal(54))
                    expect(person?.name).to(equal("Nadeem"))
                    expect(person?.city).to(equal("Karachi"))
                    expect(person?.animmal).toNot(beNil())
                    expect(person?.animmal?.name).to(equal("Dog"))
                    expect(person?.omit).to(beNil())
                }
            }
        }
    }
}

fileprivate let jsonData = """
{
    "name": "Nadeem",
    "age": "54",
    "city": "Karachi",
    "role": "admin",
    "animal": {
        "name": "Dog"
    }
}
""".data(using: .utf8)!

fileprivate class Person: SGDecodable {
    @SGSerializable
    var name: String?
    
    @SGSerializable(key: "age")
    var age: Int
    
    @SGSerializable(default: "", key: "city")
    var city: String
    
    @SGSerializable(default: Animal(), key: "animal")
    var animmal: Animal?
    
    var omit: String?
    
    required init() {}
}

fileprivate class Role: Person {
    @SGSerializable
    var role: String
}

fileprivate struct Animal: SGDecodable {
    @SGSerializable
    var name: String?
}
