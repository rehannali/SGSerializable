//
// SGBasicEncodableSpec.swift
// SGSerializable
// 
// Created by Rehan Ali on 13/10/2022 at 5:38 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation
import Quick
import Nimble
import SGSerializable

class SGBasicEncodableSpec: QuickSpec, EncodableTestSpec, DecodableTestSpec {
    override func spec() {
        describe("SG Basic Encoding") {
            var person: Person?
            var role: Role?
            beforeEach {
                person = Person()
                role = Role()
                person?.name = "Nadeem"
                person?.age = 23
                person?.city = "Sharjah"
                person?.animmal = Animal(name: SGSerializable(default: "Dog"))
                
                role?.role = "Admin"
                role?.animmal = Animal(name: SGSerializable(default: "Cat"))
                role?.age = 43
                role?.name = "Fransis"
                role?.city = "Michigan City"
                
            }
            context("Using default encoder") {
                it("should encode successfully") {
                    let data = try? self.jsonEncoder.encode(person!)
                    guard let data = data else {
                        fail("Unable to get valid data")
                        return
                    }
                    
                    let person = try? self.jsonDecoder.decode(Person.self, from: data)
                    
                    expect(person).toNot(beNil())
                    expect(person?.name).to(equal("Nadeem"))
                    expect(person?.age).to(equal(23))
                    expect(person?.city).to(equal("Sharjah"))
                }
            }
            
            context("Using Custom encoder") {
                it("should encode successfully") {
                    let dict = person?.dictionary
                    
                    expect(dict).toNot(beNil())
                    expect(dict?["name"] as? String).to(equal("Nadeem"))
                    expect(dict?["age"] as? Int).to(equal(23))
                    expect(dict?["city"] as? String).to(equal("Sharjah"))
                }
            }
            
            context("Inheritance") {
                it("should encode properly") {
                    let personDict = person?.dictionary
                    let animalDict = person?.animmal?.dictionary
                    let animal = personDict?["animal"] as? [String: Any]
                    expect(personDict).toNot(beNil())
                    expect(animalDict).toNot(beNil())
                    expect(animalDict?["name"] as? String).to(equal("Dog"))
                    expect(animal?["name"] as? String).to(equal("Dog"))
                }
            }
            
            context("Composition") {
                it("should encode properly") {
                    let role = role?.dictionary
                    expect(role).toNot(beNil())
                    expect(role?["role"] as? String).to(equal("Admin"))
                    expect(role?["name"] as? String).to(equal("Fransis"))
                    expect(role?["age"] as? Int).to(equal(43))
                    expect(role?["city"] as? String).to(equal("Michigan City"))
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

fileprivate class Person: SGEncodable, SGDecodable {
    @SGSerializable
    var name: String?
    
    @SGSerializable(key: "age")
    var age: Int
    
    @SGSerializable(default: "", key: "city")
    var city: String
    
    @SGSerializable(default: Animal(), key: "animal")
    var animmal: Animal?
    
    required init() {}
}

fileprivate class Role: Person {
    @SGSerializable
    var role: String
}

fileprivate struct Animal: SGEncodable {
    @SGSerializable
    var name: String?
}
