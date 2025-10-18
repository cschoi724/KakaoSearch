//
//  ImageRemoteDataSourceStub.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
@testable import Data
@testable import Domain

final class ImageRemoteDataSourceStub: ImageRemoteDataSource {

    enum StubError: Error { case notStubbed }

    var nextDTO: SearchResponseDTO<ImageDocumentDTO>?
    var nextError: Error?
    private(set) var lastRequest: SearchRequest?

    func fetchImages(_ request: SearchRequest) async throws -> SearchResponseDTO<ImageDocumentDTO> {
        lastRequest = request
        if let error = nextError { throw error }
        if let dto = nextDTO { return dto }
        throw StubError.notStubbed
    }
}
