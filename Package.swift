// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftAA",
    platforms: [.macOS(.v10_13), .iOS(.v12)],
    products: [
        // The AAplus product is the C++ project this one wraps. 
        .library(name: "AAplus", type: .dynamic, targets: ["AAplus"]),
        // The AABridge product provides C (not Objective-C) bindings for AAplus for Swift to use.
        .library(name: "AABridge", targets: ["AABridge"]),
        // …and finally, SwiftAA provides the Swift interface.
        .library(name: "SwiftAA", type: .dynamic, targets: ["SwiftAA"])
    ],
    targets: [
        .target(
            name: "AAplus", path: "Sources/AA+",
            exclude: ["naughter.css", "CMakeLists.txt", "AA+.htm", "AAVSOP2013.h", "AA+.h", "AAVSOP2013.cpp", "AATest.cpp"],
            publicHeadersPath: ""
        ),
        .target(name: "AABridge", dependencies: ["AAplus"]),
        .testTarget(  name: "AABridgeTests", dependencies: ["AABridge"]),
        .target(name: "SwiftAA", dependencies: ["AABridge"], exclude: ["SwiftAA-Info.plist"]),
        .testTarget(name: "SwiftAATests", dependencies: ["SwiftAA"], exclude: ["SwiftAATests-Info.plist"])
    ],
    cxxLanguageStandard: .gnucxx17
)
