import XCTest
@testable import MySQLORM

class MySQLORMTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(MySQLORM().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}