// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWOneTimePasswordView",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "WWOneTimePasswordView", targets: ["WWOneTimePasswordView"]),
    ],
    targets: [
        .target(name: "WWOneTimePasswordView", resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
