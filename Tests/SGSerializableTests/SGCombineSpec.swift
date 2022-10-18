//
// SGCombineSpec.swift
// SGSerializable
// 
// Created by Rehan Ali on 17/10/2022 at 5:02 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import Foundation
import Quick
import Nimble
import SGSerializable

class SGCombineSpec: QuickSpec {
    override func spec() {
        describe("SG Combine") {
            var object: Role?
            beforeEach {
                object = Role()
            }
            
            context("Basic Count") {
                it("should return role object attribute count") {
                    let dict = object?.toDictionary()
                    expect(object).toNot(beNil())
                    expect(dict).toNot(beNil())
                    expect(dict?.count) == 5
                }
                
                it("should return animal object attribute count") {
                    let dict = object?.animal.toDictionary()
                    expect(object).toNot(beNil())
                    expect(dict).toNot(beNil())
                    expect(dict?.count) == 1
                }
                
                context("Stripping Default or Null Values") {
                    it("should return role object attribute count") {
                        let dict = object?.toDictionary().strippingNullOrDefaults()
                        expect(object).toNot(beNil())
                        expect(dict).toNot(beNil())
                        expect(dict?.count) == 0
                    }
                    
                    it("should return animal object attribute count") {
                        let dict = object?.animal.toDictionary().strippingNullOrDefaults()
                        expect(object).toNot(beNil())
                        expect(dict).toNot(beNil())
                        expect(dict?.count) == 0
                    }
                }
            }
            
            context("Basic Value") {
                it("should return role object attributes value") {
                    let dict = object?.toDictionary()
                    expect(object).toNot(beNil())
                    expect(dict).toNot(beNil())
                    expect(dict?["roleName"] as? String) == ""
                    expect(dict?["name"] as? String) == ""
                    expect(dict?["age"] as? Int) == -1
                    expect(dict?["address"] as? String).to(beNil())
                }
                
                it("should return animal object attributes value") {
                    let dict = object?.animal.toDictionary()
                    expect(object).toNot(beNil())
                    expect(dict).toNot(beNil())
                    expect(dict?["name"] as? String) == ""
                }
            }
            
            context("Complex Inheritance and Composition") {
                beforeEach {
                    object?.roleName = "Admin"
                    object?.animal.name = "Dog"
                    object?.name = "Frank"
                    object?.age = 58
                    object?.address = "59 Air Avenue"
                }
                
                it("should get actual values in dictionary") {
                    let dict = object?.toDictionary()
                    let animal = dict?["animal"] as? [String: Any]
                    expect(object).toNot(beNil())
                    expect(dict).toNot(beNil())
                    expect(animal).toNot(beNil())
                    expect(dict?["roleName"] as? String) == "Admin"
                    expect(dict?["name"] as? String) == "Frank"
                    expect(dict?["address"] as? String) == "59 Air Avenue"
                    expect(animal?["name"] as? String) == "Dog"
                    expect(dict?["age"] as? Int) == 58
                }
                
                it("should get actual values in dictionary (Inheritance)") {
                    let dict = object?.toDictionary()
                    expect(object).toNot(beNil())
                    expect(dict).toNot(beNil())
                    expect(dict?["roleName"] as? String) == "Admin"
                    expect(dict?["name"] as? String) == "Frank"
                    expect(dict?["address"] as? String) == "59 Air Avenue"
                    expect(dict?["age"] as? Int) == 58
                }
                
                it("should get actual values in dictionary (Composition)") {
                    let dict = object?.animal.toDictionary()
                    expect(object).toNot(beNil())
                    expect(dict).toNot(beNil())
                    expect(dict?["name"] as? String) == "Dog"
                }
            }
        }
    }
}

fileprivate class Person: NSObject {
    var name = ""
    var age = -1
    var address: String?
    var animal = Animal()
}

fileprivate class Animal: NSObject {
    var name = ""
}

fileprivate class Role: Person {
    var roleName = ""
}
