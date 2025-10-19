//
//  SearchFeature.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Domain

public struct SearchFeature: Reducer {
    
    public struct State: Equatable {
        public var query: String = ""
        public var isEditing: Bool = false
        public var submittedQuery: String?

        public var recent: RecentQueriesFeature.State = .init()
        public var results: SearchResultsFeature.State = .init()

        public var errorMessage: String?
        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case queryChanged(String)
        case submit
        case clearTapped

        case recent(RecentQueriesFeature.Action)
        case results(SearchResultsFeature.Action)

        case showError(String)
    }
    
    public struct Environment {
        public let recentEnv: RecentQueriesFeature.Environment
        public  let resultsEnv: SearchResultsFeature.Environment
        
        public init(recentEnv: RecentQueriesFeature.Environment, resultsEnv: SearchResultsFeature.Environment) {
            self.recentEnv = recentEnv
            self.resultsEnv = resultsEnv
        }
    }
    
    private let env: Environment
    public init(env: Environment) {
        self.env = env
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Scope(state: \.recent, action: /Action.recent) {
            RecentQueriesFeature(env: env.recentEnv)
        }
        Scope(state: \.results, action: /Action.results) {
            SearchResultsFeature(env: env.resultsEnv)
        }
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .onAppear:
                // 화면 진입 시 최근검색 로드
                return .send(.recent(.loadRequested))

            case let .queryChanged(text):
                state.query = text
                state.isEditing = !text.isEmpty
                // 쿼리가 바뀌면 최근검색 쪽 필터링 트리거
                return .send(.recent(.filterChanged(text)))

            case .submit:
                guard !state.query.isEmpty else { return .none }
                // 최근 검색어 저장하고, 검색 실행
                state.submittedQuery = state.query
                return .merge(
                    .send(.recent(.saveRequested(state.query))),
                    .send(.results(.searchRequested(state.query)))
                )

            case .clearTapped:
                state.query = ""
                state.isEditing = false
                return .none

            case let .recent(.didSelect(query)):
                // 최근검색 탭하면 쿼리 반영 + 검색 실행
                state.query = query
                state.submittedQuery = query
                return .merge(
                    .send(.results(.searchRequested(query)))
                )

            case let .showError(message):
                state.errorMessage = message
                return .none

            case .recent, .results:
                return .none
            }
        }
    }
}
