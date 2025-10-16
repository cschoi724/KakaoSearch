import ProjectDescription
import ProjectDescriptionHelpers

let presentation = Project.target(
  name: Module.Presentation.rawValue,
  product: .framework,
  bundleId: Module.Presentation.bundleId,
  infoPlist: Info.framework,
  sources: ["Sources/**"],
  resources: ["Resources/**"],
  dependencies: [
    .project(target: Module.Domain.rawValue, path: "../Domain"),
    .project(target: Module.Core.rawValue, path: "../Core"),
    .tca,
    .swinject
  ],
  deploymentTargets: .iOS("17.0")
)

let tests = Project.target(
  name: "\(Module.Presentation.rawValue)Tests",
  product: .unitTests,
  bundleId: "\(Module.Presentation.bundleId).tests",
  infoPlist: Info.tests,
  sources: ["Tests/**"],
  dependencies: [
    .target(name: Module.Presentation.rawValue),
    .tca
  ],
  deploymentTargets: .iOS("17.0")
)

let project = Project.featureProject(
  name: Module.Presentation.rawValue,
  targets: [presentation, tests]
)
