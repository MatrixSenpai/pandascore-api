// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "PandaScoreAPI",
    platforms: [.iOS(.v12)],
    products: [
        .library(name: "PandaScoreAPI", targets: ["panda-api"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "4.5.0")
    ],
    targets: [
        .target(name: "panda-api", dependencies: ["RxSwift"]),
        .testTarget(name: "panda-apiTests", dependencies: ["panda-api", "RxSwift"])
    ],
    swiftLanguageVersions: [.v5]
)
