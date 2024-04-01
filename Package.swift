// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SGSerializable",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_15),
        .tvOS(.v11),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "SGSerializable",
            targets: ["SGSerializable"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "10.0.0"))
    ],
    targets: [
        .target(
            name: "SGSerializable",
            path: "Sources",
            resources: [.copy("PrivacyInfo.xcprivacy")]),
        .testTarget(
            name: "SGSerializableTests",
            dependencies: ["SGSerializable", "Quick", "Nimble"]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
