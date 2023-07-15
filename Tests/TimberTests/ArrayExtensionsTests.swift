@testable import Timber
import XCTest

class ArrayExtensionsTests: XCTestCase {

    func testArray_withValue_joinedUsesInterspersed() {
        let input: [Value] = [
            .init(segments: [.init(internal: "foo", external: "foo")]),
            .init(segments: [.init(internal: "bar", external: "bar")]),
            .init(segments: [.init(internal: "baz", external: "baz")]),
            .init(segments: [.init(internal: "qux", external: "qux")])
        ]

        let sut = input.joined(separator: "---")

        XCTAssertEqual(sut.internal, "foo---bar---baz---qux")
        XCTAssertEqual(sut.external, "foo---bar---baz---qux")
    }
}
