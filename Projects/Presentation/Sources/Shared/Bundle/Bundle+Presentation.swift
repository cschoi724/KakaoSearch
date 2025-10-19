//
//  Bundle+Presentation.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

private final class _PresentationBundleToken {}
extension Bundle {
    static var presentation: Bundle {
        Bundle(for: _PresentationBundleToken.self)
    }
}
