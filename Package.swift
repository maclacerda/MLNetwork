// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MLNetwork",
    platforms: [
        .iOS(v.13)
    ],
    products: [
        .library(
            name: "MLNetwork",
            targets: ["MLNetworkLayer"]
        ),
        targets: [
            .binaryTarget(
                name: "MLNetwork",
                path: "./binary-framework/MLNetwork.xcframework"
            )
        ]
    ]
)