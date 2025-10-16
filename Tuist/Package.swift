// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription
// Tuist가 SPM 제품을 어떤 타입으로 변환할지 지정(옵션, 기본은 .staticFramework)
let packageSettings = PackageSettings(
  productTypes: [
    "Alamofire": .framework,
    "ComposableArchitecture": .framework,
    "Swinject": .framework
  ]
)
#endif

let package = Package(
  name: "KakaoSearchDeps",
  dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.9.0"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.13.0"),
    .package(url: "https://github.com/Swinject/Swinject.git", from: "2.9.0")
  ]
)
