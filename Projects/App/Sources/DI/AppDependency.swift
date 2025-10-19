//
//  AppDependency.swift
//  App
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Swinject
import Domain
import Data
import Core
import Presentation

final class AppDependency {
    static let shared = AppDependency()
    let container = Container()

    private init() {
        // Auth
        container.register(AuthProvider.self) { _ in
            KakaoAPIKeyAuthProvider(apiKey: "3a07d71e13ed5cfb14121c63e7282944")
        }

        // Network
        container.register(NetworkClient.self) { r in
            DefaultNetworkClient(
                authProviders: [
                    r.resolve(AuthProvider.self)!
                ]
            )
        }

        // DataSources
        container.register(BlogRemoteDataSource.self) { r in
            BlogRemoteDataSourceImpl(client: r.resolve(NetworkClient.self)!)
        }
        container.register(ImageRemoteDataSource.self) { r in
            ImageRemoteDataSourceImpl(client: r.resolve(NetworkClient.self)!)
        }
        container.register(VideoRemoteDataSource.self) { r in
            VideoRemoteDataSourceImpl(client: r.resolve(NetworkClient.self)!)
        }
        container.register(RecentSearchLocalDataSource.self) { _ in
            RecentSearchLocalDataSourceImpl(storage: UserDefaultsStorage())
        }

        // Repositories
        container.register(BlogSearchRepository.self) { r in
            BlogSearchRepositoryImpl(remote: r.resolve(BlogRemoteDataSource.self)!)
        }
        container.register(ImageSearchRepository.self) { r in
            ImageSearchRepositoryImpl(remote: r.resolve(ImageRemoteDataSource.self)!)
        }
        container.register(VideoSearchRepository.self) { r in
            VideoSearchRepositoryImpl(remote: r.resolve(VideoRemoteDataSource.self)!)
        }
        container.register(RecentSearchRepository.self) { r in
            RecentSearchRepositoryImpl(local: r.resolve(RecentSearchLocalDataSource.self)!)
        }

        // UseCases
        container.register(SearchBlogsUseCase.self) { r in
            DefaultSearchBlogsUseCase(repository: r.resolve(BlogSearchRepository.self)!)
        }
        container.register(SearchImagesUseCase.self) { r in
            DefaultSearchImagesUseCase(repository: r.resolve(ImageSearchRepository.self)!)
        }
        container.register(SearchVideosUseCase.self) { r in
            DefaultSearchVideosUseCase(repository: r.resolve(VideoSearchRepository.self)!)
        }
        container.register(SaveRecentQueryUseCase.self) { r in
            SaveRecentQueryUseCaseImpl(repo: r.resolve(RecentSearchRepository.self)!)
        }
        container.register(LoadRecentQueriesUseCase.self) { r in
            LoadRecentQueriesUseCaseImpl(repo: r.resolve(RecentSearchRepository.self)!)
        }
    }

    // SearchFeature.Env 조립자
    func makeSearchEnv() -> SearchFeature.Environment {
        .init(
            recentEnv: .init(
                loadRecentQueries: container.resolve(LoadRecentQueriesUseCase.self)!,
                saveRecentQuery: container.resolve(SaveRecentQueryUseCase.self)!
            ),
            resultsEnv: .init(
                blogEnv: .init(searchBlogs: container.resolve(SearchBlogsUseCase.self)!),
                imageEnv: .init(searchImages: container.resolve(SearchImagesUseCase.self)!),
                videoEnv: .init(searchVideos: container.resolve(SearchVideosUseCase.self)!)
            )
        )
    }
}
