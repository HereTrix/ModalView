// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIModalView",
    platforms: [
      .iOS(.v13),
      .macOS(.v10_15),
      .tvOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftUIModalView",
            targets: ["SwiftUIModalView"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftUIModalView",
            dependencies: [])
    ]
)
