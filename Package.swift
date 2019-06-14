// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotificationBubbles",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "NotificationBubbles",
            targets: ["NotificationBubbles"]),
    ],
    targets: [
        .target(
            name: "NotificationBubbles",
            dependencies: []),
        .testTarget(
            name: "NotificationBubblesTests",
            dependencies: ["NotificationBubbles"]),
    ],
    swiftLanguageVersions: [.v4_2]
)
