// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SGSerializable",
    platforms: [
        .iOS(.v11), .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SGSerializable",
            targets: ["SGSerializable"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SGSerializable",
            dependencies: []),
        .testTarget(
            name: "SGSerializableTests",
            dependencies: ["SGSerializable"]),
    ]
)
