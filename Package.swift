// swift-tools-version:5.4

import PackageDescription


let package = Package(
    name: "Collector",
    platforms: [.macOS(.v10_15), .iOS(.v13)],
    products: [
        .library(
            name: "Collector",
            targets: ["Collector"]
        ),
        .library(
            name: "JaegerCollector",
            targets: ["Collector", "JaegerCollector"]
        ),
        .library(
            name: "PrometheusCollector",
            targets: ["Collector", "PrometheusCollector"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.22.0"),
        .package(url: "https://github.com/apple/swift-metrics.git", from: "2.1.0"),
        .package(url: "https://github.com/grpc/grpc-swift.git", from: "1.1.0"),
        .package(url: "https://github.com/MrLotU/SwiftPrometheus.git", from: "1.0.0-alpha.11"),
    ],
    targets: [
        .target(
            name: "Collector",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "Metrics", package: "swift-metrics"),
            ]
        ),
        .target(
            name: "JaegerCollector",
            dependencies: [
                .product(name: "GRPC", package: "grpc-swift"),
                .target(name: "Collector")
            ]
        ),
        .target(
            name: "PrometheusCollector",
            dependencies: [
                .product(name: "SwiftPrometheus", package: "SwiftPrometheus"),
                .target(name: "Collector")
            ]
        ),
        .testTarget(
            name: "CollectorTests",
            dependencies: [
                .target(name: "Collector")
            ]
        )
    ]
)
