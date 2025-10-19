//
//  AppRouter.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import Combine

public final class AppRouter: ObservableObject, Sendable {
    @Published public var path = NavigationPath()
    @Published public var sheet: AppRoute?
    @Published public var fullScreen: AppRoute?

    public init() {}

    @MainActor
    public func go(_ route: AppRoute) {
        path.append(route)
    }

    @MainActor
    public func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    @MainActor
    public func present(_ route: AppRoute) {
        sheet = route
    }

    @MainActor
    public func presentFull(_ route: AppRoute) {
        fullScreen = route
    }

    @MainActor
    public func openExternal(_ urlString: String) {
        guard let url = URL(string: urlString),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
