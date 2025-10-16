import ProjectDescription
import ProjectDescriptionHelpers

let data = Project.target(
  name: Module.Data.rawValue,
  product: .framework,
  bundleId: Module.Data.bundleId,
  infoPlist: Info.framework,
  sources: ["Sources/**"],
  resources: [],
  dependencies: [
    .project(target: Module.Domain.rawValue, path: "../Domain"),
    .project(target: Module.Core.rawValue, path: "../Core"),
    .alamofire
  ]
)

let tests = Project.target(
  name: "\(Module.Data.rawValue)Tests",
  product: .unitTests,
  bundleId: "\(Module.Data.bundleId).tests",
  infoPlist: Info.tests,
  sources: ["Tests/**"],
  dependencies: [
    .target(name: Module.Data.rawValue),
    .project(target: Module.Domain.rawValue, path: "../Domain")
  ]
)

let project = Project.featureProject(
  name: Module.Data.rawValue,
  targets: [data, tests]
)
