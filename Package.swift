// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MLNetwork",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MLNetwork",
            targets: ["MLNetworkLayer"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "MLNetwork",
            url: "https://github.com/maclacerda/MLNetwork/raw/master/binary-framework/MLNetwork.xcframework.zip",
            checksum: "7c02bcd0075bcc0ab1e5ebe0b9d41017bcfe45b4b34b3a6b4f4a3dcad7aef045"
        )
    ]
)