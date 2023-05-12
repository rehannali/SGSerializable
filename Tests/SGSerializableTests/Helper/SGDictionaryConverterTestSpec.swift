//
//  SGDictionaryConverterTestSpec.swift
//  
//
//  Created by Rehan Ali on 28/11/2022.
//

import Foundation
import Quick
import Nimble
import SGSerializable

class SGDictionaryConverterTestSpec: QuickSpec {
    override func spec() {
        describe("SG Dictionary Converter") {
            context("Convert Struct to Dictionary") {
                var convertedDict: [String: Any]?
                
                beforeEach {
                    let salary1 = Salary(amount: 50, currency: "DOLLAR")
                    let salary2 = Salary(amount: 100, currency: "EURO")
                    let job1 = Job(title: "Dittybopper", salary: salary1, level: 5)
                    let job2 = Job(title: "Substitute Teacher", salary: salary2, level: 5)
                    let person = Person(name: "Juzo", job: [job1, job2])
                    convertedDict = person.toDictionary()
                }
                
                it("should not be nil") {
                    expect(convertedDict).toNot(beNil())
                }
                
                it("should match name") {
                    expect(convertedDict?["name"] as? String).toNot(beNil())
                    expect(convertedDict?["name"] as? String).to(equal("Juzo"))
                }
                
                it("should validate job values") {
                    let jobs = convertedDict?["job"] as? [[String: Any]]
                    
                    expect(jobs).toNot(beNil())
                    expect(jobs?.count).to(equal(2))
                    
                    let first = jobs?.first
                    expect(first?["level"] as? Int).to(equal(5))
                    expect(first?["title"] as? String).to(equal("Dittybopper"))
                    expect(first?["salary"] as? [String: Any]).toNot(beNil())
                    expect((first?["salary"] as? [String: Any])?.count).to(equal(2))
                    
                    let second = jobs?.last
                    expect(second?["level"] as? Int).to(equal(5))
                    expect(second?["title"] as? String).to(equal("Substitute Teacher"))
                    expect(second?["salary"] as? [String: Any]).toNot(beNil())
                    expect((second?["salary"] as? [String: Any])?.count).to(equal(2))
                }
                
                it("should validate salary values") {
                    let jobs = convertedDict?["job"] as? [[String: Any]]
                    
                    let salary = jobs?.compactMap { $0["salary"] as? [String: Any] }
                    
                    expect(salary).toNot(beNil())
                    expect(salary?.count).to(equal(2))
                    
                    expect(salary?.first?["amount"] as? Int).to(equal(50))
                    expect(salary?.first?["currency"] as? String).to(equal("DOLLAR"))
                    expect(salary?.last?["amount"] as? Int).to(equal(100))
                    expect(salary?.last?["currency"] as? String).to(equal("EURO"))
                }
            }
            
            context("Convert Classes to Dictionary") {
                var convertedDict: [String: Any]?
                
                beforeEach {
                    let job1 = JobC(title: "Dittybopper", level: 5, amount: 50, currency: "DOLLAR")
                    let job2 = JobC(title: "Substitute Teacher", level: 5, amount: 100, currency: "EURO")
                    let person = PersonC(name: "Juzo", job: [job1, job2])
                    convertedDict = person.toDictionary()
                }
                
                it("should not be nil") {
                    expect(convertedDict).toNot(beNil())
                }
                
                it("should match name") {
                    expect(convertedDict?["name"] as? String).toNot(beNil())
                    expect(convertedDict?["name"] as? String).to(equal("Juzo"))
                }
                
                it("should validate job values") {
                    let jobs = convertedDict?["job"] as? [[String: Any]]
                    
                    expect(jobs).toNot(beNil())
                    expect(jobs?.count).to(equal(2))
                    
                    let first = jobs?.first
                    expect(first?["level"] as? Int).to(equal(5))
                    expect(first?["title"] as? String).to(equal("Dittybopper"))
                    expect(first?["amount"] as? Int).to(equal(50))
                    expect(first?["currency"] as? String).to(equal("DOLLAR"))
                    
                    let second = jobs?.last
                    expect(second?["level"] as? Int).to(equal(5))
                    expect(second?["title"] as? String).to(equal("Substitute Teacher"))
                    expect(second?["amount"] as? Int).to(equal(100))
                    expect(second?["currency"] as? String).to(equal("EURO"))
                }
            }
        }
    }
}

fileprivate let testDictionary = [
    "job": [
        [
            "amount": 100,
            "currency": "EURO",
            "level": 5,
            "title": "Dittybopper"
        ] as [String : Any],
        [
            "title": "Substitute Teacher",
            "amount": 50,
            "currency": "DOLLAR",
            "level": 5
        ]
    ],
    "name": "Juzo"
] as [String : Any]

fileprivate let testDictionary1 = [
    "job": [
        [
            "salary": [
                "amount": 50,
                "currency": "DOLLAR"
            ] as [String : Any],
            "level": 5,
            "title": "Dittybopper"
        ] as [String : Any],
        [
            "title": "Substitute Teacher",
            "salary": [
                "amount": 100,
                "currency": "EURO"
            ] as [String : Any],
            "level": 5
        ]
    ],
    "name": "Juzo"
] as [String : Any]

fileprivate struct Person: SGDictionaryConverter {
    let name: String
    let job: [Job]?
}

fileprivate struct Job: SGDictionaryConverter {
    let title: String
    let salary: Salary
    let level: Int
}

fileprivate struct Salary: SGDictionaryConverter {
    let amount: Int
    let currency: String
}

fileprivate class PersonC: SGDictionaryConverter {
    var name: String
    var job: [JobC]?
    
    init(name: String, job: [JobC]? = nil) {
        self.name = name
        self.job = job
    }
}

fileprivate class JobC: SalaryC {
    let title: String
    let level: Int
    
    init(title: String, level: Int, amount: Int, currency: String) {
        self.title = title
        self.level = level
        super.init(amount: amount, currency: currency)
    }
}

fileprivate class SalaryC: SGDictionaryConverter {
    let amount: Int
    let currency: String
    
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
}
