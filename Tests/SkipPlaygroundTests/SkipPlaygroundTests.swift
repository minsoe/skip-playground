// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import XCTest
import OSLog
import Foundation
@testable import SkipPlayground

let logger: Logger = Logger(subsystem: "SkipPlayground", category: "Tests")

@available(macOS 13, *)
final class SkipPlaygroundTests: XCTestCase {
    func testSkipPlayground() throws {
        logger.log("running testSkipPlayground")
        XCTAssertEqual(1 + 2, 3, "basic test")
    }
}

struct TestData : Codable, Hashable {
    var testModuleName: String
}
