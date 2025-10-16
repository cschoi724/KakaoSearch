import ProjectDescription
import ProjectDescriptionHelpers

let core = Project.target(
  name: Module.Core.rawValue,
  product: .framework,
  bundleId: Module.Core.bundleId,
  infoPlist: Info.framework,
  sources: ["Sources/**"],
  resources: [],
  dependencies: [.alamofire]
)

let tests = Project.target(
  name: "\(Module.Core.rawValue)Tests",
  product: .unitTests,
  bundleId: "\(Module.Core.bundleId).tests",
  infoPlist: Info.tests,
  sources: ["Tests/**"],
  dependencies: [.target(name: Module.Core.rawValue)]
)

let project = Project.featureProject(
  name: Module.Core.rawValue,
  targets: [core, tests]
)
