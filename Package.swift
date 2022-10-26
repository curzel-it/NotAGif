// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "NotAGif",
    platforms: [.macOS(.v11), .iOS(.v14)],
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
