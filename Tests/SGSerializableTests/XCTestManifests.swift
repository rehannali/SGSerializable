//
// XCTestManifests.swift
// SGSerializable
// 
// Created by Rehan Ali on 10/10/2022 at 9:39 PM.
// Copyright © 2022 Rehan Ali. All rights reserved.
// 

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SGSerializableTests.allTests),
    ]
}
#endif
