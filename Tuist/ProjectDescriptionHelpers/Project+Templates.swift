import ProjectDescription

public enum Module: String, CaseIterable {
  case App, Core, Domain, Data, Presentation
  public var bundleId: String { "com.annyeongjelly.kakaosearch.\(rawValue.lowercased())" }
}

public extension Project {
  static func featureProject(
    name: String,
    targets: [ProjectDescription.Target]
  ) -> Project {
    Project(
      name: name,
      organizationName: "annyeongjelly",
      options: .options(),
      settings: .settings(
        base: [
          "SWIFT_VERSION": "5.10"
        ],
        configurations: [
          .debug(name: .debug),
          .release(name: .release)
        ]
      ),
      targets: targets
    )
  }

  static func target(
    name: String,
    product: Product,
    bundleId: String,
    infoPlist: InfoPlist,
    sources: SourceFilesList,
    resources: ResourceFileElements = [],
    dependencies: [TargetDependency] = [],
    settings: Settings? = nil,
    deploymentTargets: ProjectDescription.DeploymentTargets = .iOS("15.0")
  ) -> ProjectDescription.Target {
    ProjectDescription.Target.target(
      name: name,
      destinations: ProjectDescription.Destinations.iOS,
      product: product,
      bundleId: bundleId,
      deploymentTargets: deploymentTargets,
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      scripts: [],
      dependencies: dependencies,
      settings: settings
    )
  }
}

public enum Info {
  public static let app: InfoPlist = .extendingDefault(with: [
    "UILaunchScreen": [:]
  ])
  public static let framework: InfoPlist = .default
  public static let tests: InfoPlist = .default
}

public extension TargetDependency {
  static let alamofire: TargetDependency = .external(name: "Alamofire")
  static let tca: TargetDependency = .external(name: "ComposableArchitecture")
  static let swinject: TargetDependency = .external(name: "Swinject")
}
