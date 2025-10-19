//
//  AppRootView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Domain

//public struct AppRootView: View {
//    @StateObject private var router = AppRouter()
//
//    private let searchEnv: SearchFeature.Environment
//
//    public init(searchEnv: SearchFeature.Environment) {
//        self.searchEnv = searchEnv
//    }
//
//    public var body: some View {
//        NavigationStack(path: $router.path) {
//            SearchRootView(
//                store: .init(
//                    initialState: .init(),
//                    reducer: { SearchFeature(env: searchEnv) }
//                )
//            )
//            .navigationDestination(for: AppRoute.self) { route in
//                switch route {
//                case .imageDetail(let id, let imageURL):
//                    //ImageDetailView(id: id, imageURL: imageURL)
//                case .webExternal(let url):
//                    //URLPreviewView(url: url)
//                }
//            }
//        }
//        .environmentObject(router)
//    }
//}
