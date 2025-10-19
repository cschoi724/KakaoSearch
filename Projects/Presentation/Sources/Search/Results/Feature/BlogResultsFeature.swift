//
//  BlogResultsFeature.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Domain

public struct BlogResultsFeature: Reducer {

    public struct State: Equatable {
        public var query: String = ""
        public var items: [BlogItem] = []
        public var page: Int = 1
        public var size: Int = 15
        public var isLoading: Bool = false
        public var isRefreshing: Bool = false
        public var isEnd: Bool = true
        public var errorMessage: String? = nil

        public init() {}
    }

    public enum Action {
        case setQuery(String)
        case submit // 검색 실행(첫 페이지)
        case loadNextPage   // 리스트 끝에서 추가 로드
        case refresh    // 당겨서 새로고침(첫 페이지 갱신)
        case didSelect(Int)

        case searchResponse(TaskResult<(items: [BlogItem], pageInfo: PageInfo)>, isRefresh: Bool)
    }

    public struct Environment: Sendable {
        public let searchBlogs: SearchBlogsUseCase
        public  init(searchBlogs: SearchBlogsUseCase) {
            self.searchBlogs = searchBlogs
        }
    }

    private let env: Environment

    public init(env: Environment) {
        self.env = env
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .setQuery(text):
                state.query = text
                state.errorMessage = nil
                return .none

            case .submit:
                guard !state.query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    return .none
                }
                state.isLoading = true
                state.isRefreshing = false
                state.errorMessage = nil
                state.items = []
                state.page = 1
                state.isEnd = false

                let request = SearchRequest(
                    query: state.query,
                    sort: "accuracy",
                    page: state.page,
                    size: state.size
                )

                return .run { [env] send in
                    await send(
                        .searchResponse(
                            TaskResult { try await env.searchBlogs(request) },
                            isRefresh: true
                        )
                    )
                }

            case .loadNextPage:
                guard !state.isLoading, !state.isEnd else { return .none }
                state.isLoading = true
                state.errorMessage = nil
                state.page += 1

                let request = SearchRequest(
                    query: state.query,
                    sort: "accuracy",
                    page: state.page,
                    size: state.size
                )

                return .run { [env] send in
                    await send(
                        .searchResponse(
                            TaskResult { try await env.searchBlogs(request) },
                            isRefresh: false
                        )
                    )
                }

            case .refresh:
                guard !state.query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    return .none
                }
                state.isRefreshing = true
                state.isLoading = true
                state.errorMessage = nil
                state.page = 1
                state.isEnd = false

                let request = SearchRequest(
                    query: state.query,
                    sort: "accuracy",
                    page: state.page,
                    size: state.size
                )

                return .run { [env] send in
                    await send(
                        .searchResponse(
                            TaskResult { try await env.searchBlogs(request) },
                            isRefresh: true
                        )
                    )
                }
            case .didSelect(let index):
                return .none
            case let .searchResponse(.success(result), isRefresh):
                state.isLoading = false
                state.isRefreshing = false
                state.errorMessage = nil
                state.isEnd = result.pageInfo.isEnd
                if isRefresh {
                    state.items = result.items
                } else {
                    state.items.append(contentsOf: result.items)
                }
                return .none

            case let .searchResponse(.failure(error), _):
                state.isLoading = false
                state.isRefreshing = false
                state.errorMessage = (error as NSError).localizedDescription
                if state.page > 1 { state.page -= 1 }
                return .none
            }
        }
    }
}
