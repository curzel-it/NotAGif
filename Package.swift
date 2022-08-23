// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "NotAGif",
    platforms: [.macOS(.v12), .iOS(.v15)],
    products: [
        .library(
            name: "NotAGif",
            targets: ["NotAGif"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NotAGif",
            dependencies: []
        ),
        .testTarget(
            name: "NotAGifTests",
            dependencies: ["NotAGif"]
        )
    ]
)
