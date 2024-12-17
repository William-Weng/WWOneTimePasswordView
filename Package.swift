// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWOneTimePasswordView",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "WWOneTimePasswordView", targets: ["WWOneTimePasswordView"]),
    ],
    targets: [
        .target(name: "WWOneTimePasswordView"),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
