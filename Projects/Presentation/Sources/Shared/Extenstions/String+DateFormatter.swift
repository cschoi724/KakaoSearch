//
//  String+DateFormatter.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

extension String {
    func kakaoDateTime() -> String {
        // 1) ISO8601 (소수초 포함) 시도
        if let date = Self.iso8601WithFraction.date(from: self)
                 ?? Self.iso8601NoFraction.date(from: self)
                 ?? Self.backup1.date(from: self)
                 ?? Self.backup2.date(from: self) {
            return Self.output.string(from: date)
        }
        return self
    }

    // MARK: - Formatters (static 재사용으로 성능/GC 안정)
    private static let iso8601WithFraction: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // "…SSS+09:00"
        return f
    }()

    private static let iso8601NoFraction: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime] // "…+09:00" (소수초 없음)
        return f
    }()

    // 일부 API/환경에서 ":" 없는 오프셋 또는 경미한 포맷 차이를 대비
    private static let backup1: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX" // 가장 관대한 ISO 오프셋
        return f
    }()

    private static let backup2: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX" // 소수초 없는 변형
        return f
    }()

    private static let output: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "yyyy. M. d"
        return f
    }()
}
