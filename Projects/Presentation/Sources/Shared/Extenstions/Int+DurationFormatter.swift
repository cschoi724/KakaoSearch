//
//  Int+DurationFormatter.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

extension Int {
    func kakaoPlayTime() -> String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = self % 60

        if hours > 0 {
            // 1시간 이상일 때 → hh:mm:ss
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            // 1시간 미만 → m:ss
            return String(format: "%d:%02d", minutes, seconds)
        }
    }
}
