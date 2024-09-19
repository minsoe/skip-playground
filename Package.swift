// swift-tools-version: 5.9
// This is a Skip (https://skip.tools) package,
// containing a Swift Package Manager project
// that will use the Skip build plugin to transpile the
// Swift Package, Sources, and Tests into an
// Android Gradle Project with Kotlin sources and JUnit tests.
import PackageDescription

let package = Package(
    name: "skip-playground",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "SkipPlaygroundApp", type: .dynamic, targets: ["SkipPlayground"]),
        .library(name: "TMDBMovieApi", type: .dynamic, targets: ["TMDBMovieApi"]),
        .library(name: "MovieUI", type: .dynamic, targets: ["MovieUI"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.0.7"),
        .package(url: "https://source.skip.tools/skip-foundation.git", from: "1.0.0"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "1.0.0"),
        .package(url: "https://github.com/minsoe/SkippingFlow.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "SkipPlayground",
            dependencies: [
                "MovieUI",
                .product(name: "SkipUI", package: "skip-ui"),
            ],
            resources: [
                .process("Resources")
            ],
            plugins: [.plugin(name: "skipstone", package: "skip")]
        ),
        .target(
            name: "MovieUI",
            dependencies: [
                "TMDBMovieApi",
                "SkippingFlow",
                .product(name: "SkipUI", package: "skip-ui"),
            ],
            plugins: [.plugin(name: "skipstone", package: "skip")]
        ),
        .target(
            name: "TMDBMovieApi",
            dependencies: [
                .product(name: "SkipFoundation", package: "skip-foundation")
            ],
            plugins: [.plugin(name: "skipstone", package: "skip")]
        ),
        .testTarget(
            name: "SkipPlaygroundTests",
            dependencies: [
                "SkipPlayground", 
                .product(name: "SkipTest", package: "skip")
            ],
            plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(
            name: "TMDBMovieApiTests",
            dependencies: [
                "TMDBMovieApi", 
                .product(name: "SkipTest", package: "skip")
            ],
            plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
