// swift-tools-version:5.4

import PackageDescription


let package = Package(
    name: "Collector",
    platforms: [.macOS(.v10_15), .iOS(.v13)],
    products: [
        .library(
            name: "Collector",
            targets: ["MetricCollector", "TraceCollector"]),

        .library(
            name: "MetricCollector",
            targets: ["MetricCollector"]),
        .library(
            name: "PrometheusCollector",
            targets: ["PrometheusCollector"]),

        .library(
            name: "TraceCollector",
            targets: ["TraceCollector"]),
        .library(
            name: "JaegerCollector",
            targets: ["JaegerCollector"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-metrics.git", from: "2.1.0"),
        .package(url: "https://github.com/grpc/grpc-swift.git", from: "1.1.0"),
        .package(url: "https://github.com/MrLotU/SwiftPrometheus.git", from: "1.0.0-alpha.11"),
    ],
    targets: [

        .target(
            name: "MetricCollector",
            dependencies: [
                .product(name: "CoreMetrics", package: "swift-metrics"),
            ]),
        .target(
            name: "PrometheusCollector",
            dependencies: [
                .product(name: "SwiftPrometheus", package: "SwiftPrometheus"),
                .target(name: "MetricCollector")
            ]),
        .testTarget(
            name: "PrometheusCollectorTests",
            dependencies: [
                .target(name: "PrometheusCollector")
            ]),

        .target(
            name: "TraceCollector",
            dependencies: []),
        .target(
            name: "JaegerCollector",
            dependencies: [
                .product(name: "GRPC", package: "grpc-swift"),
                .target(name: "TraceCollector")
            ]),
        .testTarget(
            name: "JaegerCollectorTests",
            dependencies: [
                .target(name: "JaegerCollector")
            ]),

    ]
)
