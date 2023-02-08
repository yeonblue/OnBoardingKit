// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OnBoardingKit",
    platforms: [ // 지원범위 설정
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "OnBoardingKit",
            targets: ["OnBoardingKit"]),
    ],
    dependencies: [ // 관련 dependency 지정, Moya의 경우 Alamofire
        .package(url: "https://github.com/Snapkit/SnapKit", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "OnBoardingKit",
            dependencies: ["SnapKit"]), // dependency 추가
        .testTarget(
            name: "OnBoardingKitTests",
            dependencies: ["OnBoardingKit"]),
    ]
)
