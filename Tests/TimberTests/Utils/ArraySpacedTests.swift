@testable import Timber
import XCTest

class ArraySpacedTests: XCTestCase {
    func testArray_withNoValues_returnsEmptyString() async throws {
        // Arrange
        let input: [String] = []

        // Act
        let output = input.spaced

        // Assert
        XCTAssertEqual(output, "")
    }
    func testArray_withSingleEmptyString_returnsString() async throws {
        // Arrange
        let input = [""]

        // Act
        let output = input.spaced

        // Assert
        XCTAssertEqual(output, "")
    }
    func testArray_withSingleValue_returnsString() async throws {
        // Arrange
        let input = ["foo"]

        // Act
        let output = input.spaced

        // Assert
        XCTAssertEqual(output, "foo")
    }
    func testArray_withMultipleEmptyStrings_returnsSpaces() async throws {
        // Arrange
        let count = Int.random(in: 1...100)
        let input = Array(repeating: "", count: count)

        // Act
        let output = input.spaced

        // Assert
        XCTAssertEqual(output, String(repeating: " ", count: count - 1))
    }
    func testArray_withMultipleStrings_returnsStringsWithSpaces() async throws {
        // Arrange
        let input = ["foo", "bar", "qux"]

        // Act
        let output = input.spaced

        // Assert
        XCTAssertEqual(output, "foo bar qux")
    }
}
