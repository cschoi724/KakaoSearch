//
//  RecentQueriesFeature.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Domain

public struct RecentQueriesFeature: Reducer {
    
    public struct State: Equatable {
        public var all: [String] = []
        public var filtered: [String] = []
        public init() {}
    }

    public enum Action: Equatable {
        case loadRequested
        case filterChanged(String)
        case saveRequested(String)
        case deleteRequested(String)
        case didSelect(String)
        case loaded([String])
        case failed(String)
    }


    public struct Environment {
        let loadRecentQueries: LoadRecentQueriesUseCase
        let saveRecentQuery: SaveRecentQueryUseCase
    }

    private let env: Environment
    public init(env: Environment) {
        self.env = env
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadRequested:
                let list = env.loadRecentQueries()
                state.all = list
                state.filtered = list
                return .none

            case let .filterChanged(query):
                if query.isEmpty {
                    state.filtered = state.all
                } else {
                    state.filtered = state.all.filter { $0.localizedCaseInsensitiveContains(query) }
                }
                return .none

            case let .saveRequested(query):
                env.saveRecentQuery(query)
                let list = env.loadRecentQueries()
                state.all = list
                state.filtered = list
                return .none
                
            case let .deleteRequested(q):
                state.all.removeAll { $0 == q }
                state.filtered.removeAll { $0 == q }
                return .none

            case .didSelect:
                return .none

            case let .loaded(list):
                state.all = list
                state.filtered = list
                return .none

            case let .failed(message):
                return .none
            }
        }
    }
}
