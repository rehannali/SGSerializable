//
// File.swift
// SGSerializable
// 
// Created by Rehan Ali on 10/10/2022 at 9:34 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 


import XCTest
import Quick

@testable import SGSerializableTests

let alltests = [
    SGBasicDecodableSpec.self,
    SGAdvancedDecodableSpec.self,
    SGAdvancedEncodableSpec.self,
    SGBasicEncodableSpec.self,
    SGBasicTransformSerializable.self,
    SGAdvancedTransformSerializable.self,
    SGCombineSpec.self
]

Quick.QCKMain(alltests)
