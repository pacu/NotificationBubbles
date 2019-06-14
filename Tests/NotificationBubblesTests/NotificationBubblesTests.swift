import XCTest
@testable import NotificationBubbles

final class NotificationBubblesTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(NotificationBubbles().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
