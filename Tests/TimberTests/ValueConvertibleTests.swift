@testable import Timber
import XCTest

class ValueConvertibleTests: XCTestCase {

    func testAnyValueConformingToValueConvertible_canBeInterpolated() {
        var messages: [String] = []
        let destination = Destination(send: { message, _, _ in
            messages.append(message.value.internal)
        })
        let config = Configuration(destinations: [destination])
        let logger = Logger(config: config)

        let elvis = Person(name: "Elvis", age: 42)
        logger.log(.default(.info, "\(elvis)"))

        XCTAssertEqual(messages, ["[DEFAULT] Elvis (42)"])
    }
}

private struct Person {
    var name: String
    var age: Int
}

extension Person: ValueConvertible {
    var logValue: Value { Value(stringLiteral: "\(name) (\(age))") }
}
