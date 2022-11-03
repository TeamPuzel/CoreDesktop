// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "CoreDesktop",
    dependencies: [],
    targets: [
        .executableTarget(
            name: "CoreDesktop",
            dependencies: ["X11"]),
        .systemLibrary(
            name: "X11",
            pkgConfig: "x11",
            providers: [.apt(["libx11-dev"])])
    ]
)
