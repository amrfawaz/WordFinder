// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Package",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]),
        .library(
            name: "EnvironmentVariables",
            targets: ["EnvironmentVariables"]),
        .library(
            name: "CoreInterface",
            targets: ["CoreInterface"]),
        .library(
            name: "Package",
            targets: ["Package"]),
        .library(
            name: "Search",
            targets: ["Search"]
        ),
        .library(
            name: "RealmManager",
            targets: ["RealmManager"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-cocoa", from: "10.5.0")
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: []
        ),
        .target(
            name: "EnvironmentVariables",
            dependencies: []
        ),
        .target(
            name: "CoreInterface",
            dependencies: []
        ),
        .target(
            name: "Package"
        ),
        .target(
            name: "Search",
            dependencies: [
                "EnvironmentVariables",
                "CoreInterface",
                "RealmManager"
            ]
        ),
        .target(
            name: "RealmManager",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-cocoa")
            ]
        ),

        .testTarget(
            name: "PackageTests",
            dependencies: ["Package"]
        ),
        .testTarget(
            name: "SearchTests",
            dependencies: [
                "Search",
                "RealmManager"
            ]
        ),

    ]
)
