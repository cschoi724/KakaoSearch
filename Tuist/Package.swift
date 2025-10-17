// swift-tools-version: 5.10
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
  productTypes: [
    "Alamofire": .framework,
    "Swinject": .framework
  ],
  baseSettings: .settings(
    defaultSettings: .recommended
  )
)
#endif

let package = Package(
  name: "KakaoSearchDeps",
  platforms: [
    .iOS(.v15)
  ],
  dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.9.1"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.15.0"),
    .package(url: "https://github.com/Swinject/Swinject.git", from: "2.9.1")
  ]
)
