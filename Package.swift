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
            targets: ["MLNetwork"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "MLNetwork",
            url: "https://github.com/maclacerda/MLNetwork/raw/master/binary-framework/MLNetwork.xcframework.zip",
            checksum: "06b1b7f294ec1d3e09fb2f84944cfcb5541c6a13302158c7cd40b868608ebb8a"
        )
    ]
)