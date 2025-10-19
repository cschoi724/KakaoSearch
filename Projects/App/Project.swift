import ProjectDescription
import ProjectDescriptionHelpers

let app = Project.target(
  name: Module.App.rawValue,
  product: .app,
  bundleId: Module.App.bundleId,
  infoPlist: Info.app,
  sources: ["Sources/**"],
  resources: ["Resources/**"],
  dependencies: [
    .project(target: Module.Presentation.rawValue, path: "../Presentation"),
    .project(target: Module.Domain.rawValue, path: "../Domain"),
    .project(target: Module.Core.rawValue, path: "../Core"),
    .project(target: Module.Data.rawValue, path: "../Data"),
    .alamofire, .tca, .swinject
  ],
  deploymentTargets: .iOS("17.0")
)

let appTests = Project.target(
  name: "\(Module.App.rawValue)Tests",
  product: .unitTests,
  bundleId: "\(Module.App.bundleId).tests",
  infoPlist: Info.tests,
  sources: ["Tests/**"],
  dependencies: [
    .target(name: Module.App.rawValue),
    .tca
  ],
  deploymentTargets: .iOS("17.0")
)

let project = Project.featureProject(
  name: Module.App.rawValue,
  targets: [app, appTests]
)
