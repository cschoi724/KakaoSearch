//
//  Logger.swift
//  Core
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import os.log

public protocol Logger {
    func debug(_ message: @autoclosure () -> String, file: String, line: Int)
    func info(_ message: @autoclosure () -> String, file: String, line: Int)
    func warn(_ message: @autoclosure () -> String, file: String, line: Int)
    func error(_ message: @autoclosure () -> String, file: String, line: Int)
}

public extension Logger {
    @inlinable
    func debug(_ message: @autoclosure () -> String, file: String = #fileID, line: Int = #line) {
        debug(message(), file: file, line: line)
    }
    @inlinable
    func info(_ message: @autoclosure () -> String, file: String = #fileID, line: Int = #line) {
        info(message(), file: file, line: line)
    }
    @inlinable
    func warn(_ message: @autoclosure () -> String, file: String = #fileID, line: Int = #line) {
        warn(message(), file: file, line: line)
    }
    @inlinable
    func error(_ message: @autoclosure () -> String, file: String = #fileID, line: Int = #line) {
        error(message(), file: file, line: line)
    }
}

public final class DefaultLogger: Logger {

    private let oslog: OSLog

    public init(category: String = "app", bundle: Bundle = .main) {
        let bundleID = bundle.bundleIdentifier ?? "com.annyeongjelly"
        self.oslog = OSLog(subsystem: bundleID, category: category)
    }

    public func debug(_ message: @autoclosure () -> String, file: String, line: Int) {
        os_log(.debug, log: oslog, "[DEBUG] %{public}@:%{public}d — %{public}@", file, line, message())
    }

    public func info(_ message: @autoclosure () -> String, file: String, line: Int) {
        os_log(.info, log: oslog, "[INFO] %{public}@:%{public}d — %{public}@", file, line, message())
    }

    public func warn(_ message: @autoclosure () -> String, file: String, line: Int) {
        os_log(.default, log: oslog, "[WARN] %{public}@:%{public}d — %{public}@", file, line, message())
    }

    public func error(_ message: @autoclosure () -> String, file: String, line: Int) {
        os_log(.error, log: oslog, "[ERROR] %{public}@:%{public}d — %{public}@", file, line, message())
    }
}
