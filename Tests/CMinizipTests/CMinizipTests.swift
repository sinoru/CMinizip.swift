import XCTest
@testable import CMinizip

final class CMinizipTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CMinizip().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
