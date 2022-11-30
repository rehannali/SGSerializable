//
//  SGDictionaryConverter.swift
//  
//
//  Created by Rehan Ali on 24/11/2022.
//

import Foundation

    /// This protocol is used to convert any `struct` or `class` into dictionary.
    /// Inheritance and Composition works out of the box. You have to conform from
    /// this protocol and get access to `toDictionary()`.
    ///
    /// - **Example using struct**
    ///
    /// ```swift
    /// struct Person: SGDictionaryConverter {
    ///    let name: String
    ///    let jobs: [Job]?
    ///    let errors: [String]?
    /// }
    ///
    /// struct Job: SGDictionaryConverter {
    ///    let title: String
    ///    let level: Int
    /// }
    /// ```
    ///
    /// - **Example using classes**
    ///
    ///```swift
    /// class Person: SGDictionaryConverter {
    ///     var name: String = ""
    ///     var jobs: [Job]?
    ///     var errors: [String]?
    /// }
    ///
    /// class Salary: SGDictionaryConverter {
    ///     var amount: Int = 0
    ///     var currency: String = ""
    /// }
    ///
    /// class Job: Salary {
    ///     var title: String = ""
    ///     var level: Int = 0
    /// }
    /// ```
public protocol SGDictionaryConverter {
    func toDictionary() -> [String: Any]
}

public extension SGDictionaryConverter {
    func toDictionary() -> [String: Any] {
        var mirror: Mirror? = Mirror(reflecting: self)
        
        let dict = getDictionary(with: &mirror)
        
        return dict
    }
    
    private func getDictionary(with mirror: inout Mirror?) -> [String: Any] {
        var dictionary = [String: Any]()
        
        repeat {
            guard let children = mirror?.children else { return [:] }
            
            for child in children {
                guard var key = child.label else { continue }
                
                if key.hasPrefix("_") {
                    key.remove(at: key.startIndex)
                }
                
                if let dictObject = child.value as? SGDictionaryConverter {
                    dictionary[key] = dictObject.toDictionary()
                }else if let dictObjectCollection = child.value as? [SGDictionaryConverter] {
                    dictionary[key] = dictObjectCollection.map { $0.toDictionary() }
                }else if let dictCollection = child.value as? [Any] {
                    dictionary[key] = dictCollection
                }else {
                    dictionary[key] = child.value
                }
            }
            
            mirror = mirror?.superclassMirror
        } while mirror != nil
        
        return dictionary
    }
}
