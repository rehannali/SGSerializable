# SGSerializable

Enhancement of current codable protocol using property wrappers for easier access and better [en/de]coding of JSON. The goal of these property wrappers is to avoid implementing custom initializer for decoder, encoder, sometimes coding keys and suffer through boilerplate code.

[![Swift Package Manager](https://img.shields.io/badge/swift%20package%20manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
![Platforms](https://img.shields.io/static/v1?label=Platforms&message=iOS%20|%20macOS%20|%20tvOS%20|%20watchOS%20|%20Linux&color=brightgreen)
![MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg) </br>
[![Build Status](https://github.com/rehannali/SGSerializable/actions/workflows/CI.yml/badge.svg)](https://github.com/rehannali/SGSerializable/actions/workflows/CI.yml)
[![CircleCI](https://circleci.com/gh/rehannali/SGSerializable/tree/master.svg?style=svg)](https://circleci.com/gh/rehannali/SGSerializable/?branch=master)
[![DeepSource](https://deepsource.io/gh/rehannali/SGSerializable.svg/?label=active+issues&show_trend=true&token=NJ557_fHlmvQMIpy9hTDjU6d)](https://deepsource.io/gh/rehannali/SGSerializable/?ref=repository-badge)

- [SGSerializable](#sgserializable)
  - [Features](#features)
      - [SGCodable](#sgcodable)
      - [SGSerializable](#sgserializable-1)
      - [SGTransformSerializable](#sgtransformserializable)
    - [Example](#example)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Custom initializer](#custom-initializer)
  - [Custom Transformer Implementation](#custom-transformer-implementation)
    - [Custom initializer for tranformable](#custom-initializer-for-tranformable)
  - [Classes to Dictionary](#classes-to-dictionary)
    - [Strip Null or Default Values](#strip-null-or-default-values)
  - [Helper Functions for [De/En]coding](#helper-functions-for-deencoding)
      - [Decoable Helpers](#decoable-helpers)
      - [Encodable Helpers](#encodable-helpers)
    - [Contribute](#contribute)

## Features

#### SGCodable

- Typed alias with `SGDecodable` & `SGEncodable`
- Custom [en/de]coding using property wrappers.
- This protocol is required for use property wrappers mentioned below.

#### SGSerializable

- No need to write your own custom `init(from decoder: Decoder) throws` and `func encode(to encoder: Encoder) throws`
- Non need to write custom CodingKeys.
- Custom Decoding key
- Use property name if key isn't mentioned.
- Works with inheritance and composition.
- Custom Transformer implementation
- Default transformer classes i.e. `StringToURL` etc. List is available below.
- Default Value if decoding failed or not provided. You can provide own default value as well.

```swift
@SGSerializable(default: "", key: "your_key", type: .auto)
var key: String?
```

#### SGTransformSerializable

- Custom tranformable classes if required or you can use default ones.
- Transforming objects to your own type like `String` to Native `URL`.

### Example

```swift
struct Foo: SGCodable {
    @SGSerializable
    var key: String?
    
    @SGSerializable(default: [])
    var items: [String]
    
    @SGSerializable(key: "crypto")
    var cryptography: [String: String]
    
    @SGSerializable
    var values: [Double]?
}
```

```swift
struct Person: SGCodable {
    @SGTransformSerializable<StringToURL>
    var profilePictureURL: URL?
}
```

## Requirements

- iOS 11.0+ / macOS 10.15+ / tvOS 11.0+ / watchOS 3.0+
- Xcode 12+
- Swift 5.5+

## Installation

**Swift Package Manager**

URL:
`https://github.com/rehannali/SGSerializable.git`

Add this to the depedencies in your `Package.swift` manifest file.

```swift
dependencies: [
    .package(url: "https://github.com/rehannali/SGSerializable.git")
]
```

## Usage

- Mark all properties with `SGSerializable`.
- Mark your model class/struct with `SGCodable`.
- You can use either `SGDecodable` or `SGEncodable` for decoding and encoding respectively.

```swift
class Person: SGDecodable {
    @SGSerializable(type: .string)
    var name: String?
    
    @SGSerializable(key: "age")
    var age: Int
    
    @SGSerializable(default: "", key: "city")
    var city: String
    
    @SGSerializable(default: Animal(), key: "animal")
    var animmal: Animal?
    
    required init() {}
}

class Role: Person {
    @SGSerializable
    var role: String
}

struct Animal: SGDecodable {
    @SGSerializable
    var name: String?
}
```

```json
{
    "name": "John",
    "age": "12",
    "city": "London"
}
```

Above mentioned JSON model successfully decode into `Person` class. It will successfully decode age: `String` into age: `Int`.

**If type is provided, it'll use that type to downcast the value. Default: `.auto` will be used.**

> Other available `CodingTypes` are mentioned below.

<details>
<summary>CodingType</summary>

</br>

```swift
case int
case double
case float
case bool
case string
case auto
case none
```
</details>

### Custom initializer

```swift
struct Person: SGCodable {
    init(name: String?) {
        self.$name = name
    }

    @SGSerializable
    var name: String
}
```

## Custom Transformer Implementation
You can create own transormation by conforming to `SGTranformable`.

```swift
struct StringToBool: SGTranformable {
    typealias FromType = String
    typealias ToType = Bool

    static func transform(from value: String?) -> Bool? {
        guard let value = value else { return nil }
        switch value {
            case "true": return true
            default: return false
        }
    }

    static func transform(from value: Bool?) -> String? {
        guard let value = value else { return nil }
        let stringValue = value ? "true" : "false"
        return stringValue
    }
}

struct Person: SGCodable {
    @SGTransformSerializable<StringToBool>
    var isLogin: Bool?
}
```

You can access optional values by access attributes directly.
```swift
let person = Person()
let isLogin = person.isLogin
```

now `isLogin` is optional for transform classes.
You can access non optional values like `person.$isLogin`. It can automatically gives you default value of else `fatalError` if not found because of programming error. Make sure you provide default value for custom objects if you want to access non-optional value.

### Custom initializer for tranformable

```swift
struct Person: SGCodable {
    init(isLogin: Bool?) {
        self.isLogin = isLogin
    }

    @SGTransformSerializable<StringToBool>
    var isLogin: Bool?
}
```

<details>
<summary>Defaut Transformer Classes</summary>

</br>

```swift
StringToBase64Data
StringToDateISO8601
StringToDateRFC3339
TimeIntervalToDate
StringToURL
```

</details>

## Classes to Dictionary

There is time we need to add custom function or computed property to provide dictionary from object as we write it manually.
Now it is possible by conforming your class to `NSObject` or `NSObjectProtocol` and get dictionary with `object.swiftDictionary`

```swift
class Person: NSObject {
    var name = "Frank"
    var age = -1
    var address: String?
}

let person = Person()
person.swiftDictionary
```

### Strip Null or Default Values

**If you want to omit optional or default values like empty string or nil, you can use `strippingNullOrDefaults()` to any `Array` or `Dictionary`**.

```swift
let person = Person()
person.swiftDictionary.strippingNullOrDefaults()
```

it will omit default and nil values which can be useful while performing network request.

**End Result:**
```swift
["name": "Frank"]
```

**Inheritance and Composition works out of the box with `swiftDictionary` and `strippingNullOrDefaults()`**

## Helper Functions for [De/En]coding

Define class/struct using required protocol `SGCodable`.

```swift
struct Person {
    @SGSerializable
    var name: String?
}
```

#### Decoable Helpers

```swift
let person = try Person.initialize(with: jsonData)
let person = try Person.initialize(with: jsonString)
let person = try Person.initialize(from: jsonURL)
```

or you can use like this:

```swift
let person = try [Person].initialize(with: jsonData)
let person = try [Person].initialize(with: jsonString)
let person = try [Person].initialize(from: jsonURL)
```

#### Encodable Helpers

```swift
let jsonString = person.jsonString()
let jsonData = person.jsonData()
let dictionary = person.dictionary
```
### Contribute

This is only a tip of the iceberg of what we can achieve using Property Wrappers and how it can be improved [de/en]coding of JSON using property wrappers in Swift. If there is a any custom tranformation that could be added feel free to open an issue requesting it and/or submit a pull request with the new option.
