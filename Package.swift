// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExampleToolForBuildProject",
    platforms: [.macOS(.v11)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.0"),
        .package(name: "SwiftToolShellExecutor", url: "https://github.com/mklinkov/SwiftToolShellExecutor", .branch("master"))
    ],
    targets: [
        .executableTarget(name: "ExampleToolForBuildProject",
                          dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"), "SwiftToolShellExecutor" ])
    ]
)
