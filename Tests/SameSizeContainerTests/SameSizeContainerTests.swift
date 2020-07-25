import XCTest
@testable import SameSizeContainer

final class SameSizeContainerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SameSizeContainer().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
