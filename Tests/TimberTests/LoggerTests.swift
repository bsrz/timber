@testable import Timber
import XCTest

final class LoggerTests: XCTestCase {
    func testLoggerOutput() throws {
        // Arrange
        var messages: [String] = []
        let dest = Destination {
            messages.append(
                MessageFormatter.format(
                    message: $0,
                    config: $1,
                    execution: $2
                )
            )
        }
        let config = Configuration(
            destinations: [dest],
            sessionId: { "session id" },
            uniqueId: { "unique id" }
        )

        var count = 0
        let logger = Logger(
            config: config,
            precondition: { condition, _, _ , _ in
                count += condition() == false ? 1 : 0
            }
        )

        // Act
        logger.log(.default(.error, "error; halt execution"), execution: .halt)
        logger.log(.default(.error, "error"))
        logger.log(.default(.warning, "warning"))
        logger.log(.default(.info, "info"))
        logger.log(.default(.debug, "debug; halt execution"), execution: .halt)
        logger.log(.default(.verbose, "verbose"))

        // Assert
        XCTAssertEqual(messages, [
            "🧨 🟥 [Error] \(URL(fileURLWithPath: #file).lastPathComponent):32 \(#function) unique id session id [DEFAULT] error; halt execution",
            "🟥 [Error] \(URL(fileURLWithPath: #file).lastPathComponent):33 \(#function) unique id session id [DEFAULT] error",
            "🟨 [Warning] \(URL(fileURLWithPath: #file).lastPathComponent):34 \(#function) unique id session id [DEFAULT] warning",
            "🟩 [Info] \(URL(fileURLWithPath: #file).lastPathComponent):35 \(#function) unique id session id [DEFAULT] info",
            "🧨 🟦 [Debug] \(URL(fileURLWithPath: #file).lastPathComponent):36 \(#function) unique id session id [DEFAULT] debug; halt execution",
            "🟪 [Verbose] \(URL(fileURLWithPath: #file).lastPathComponent):37 \(#function) unique id session id [DEFAULT] verbose"
        ])

        XCTAssertEqual(count, 2)
    }
}
