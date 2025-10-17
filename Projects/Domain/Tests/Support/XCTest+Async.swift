//
//  XCTest+Async.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import XCTest

extension XCTestCase {
  func XCTAssertThrowsErrorAsync<T>(
    _ expression: @autoclosure () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line,
    _ errorHandler: (_ error: Error) -> Void = { _ in }
  ) async {
    do {
      _ = try await expression()
      XCTFail(message(), file: file, line: line)
    } catch {
      errorHandler(error)
    }
  }
}
