import ProjectDescription
import ProjectDescriptionHelpers

let domain = Project.target(
  name: Module.Domain.rawValue,
  product: .framework,
  bundleId: Module.Domain.bundleId,
  infoPlist: Info.framework,
  sources: ["Sources/**"],
  resources: [],
  dependencies: []
)

let tests = Project.target(
  name: "\(Module.Domain.rawValue)Tests",
  product: .unitTests,
  bundleId: "\(Module.Domain.bundleId).tests",
  infoPlist: Info.tests,
  sources: ["Tests/**"],
  dependencies: [.target(name: Module.Domain.rawValue)]
)

let project = Project.featureProject(
  name: Module.Domain.rawValue,
  targets: [domain, tests]
)
