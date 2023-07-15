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
        let veryPrivateInformation = "very private information"
        logger.log(.default(.error, "error; halt execution \(veryPrivateInformation)"), execution: .halt)
        logger.log(.default(.error, "error \(veryPrivateInformation, .public)"))
        logger.log(.default(.warning, "warning \(veryPrivateInformation)"))
        logger.log(.default(.info, "info \(veryPrivateInformation, .public)"))
        logger.log(.default(.debug, "debug; halt execution"), execution: .halt)
        logger.log(.default(.verbose, "verbose \(verbatim: "veryPrivateInformation")"))
        logger.log(.default(.verbose, "verbose \(verbatim: "veryPrivateInformation", .public)"))

        for message in messages {
            print(message)
        }

        // Assert
        XCTAssertEqual(messages, [
            "🧨 🟥 [Error] \(URL(fileURLWithPath: #file).lastPathComponent):33 \(#function) unique id session id [DEFAULT] error; halt execution <REDACTED>",
            "🟥 [Error] \(URL(fileURLWithPath: #file).lastPathComponent):34 \(#function) unique id session id [DEFAULT] error very private information",
            "🟨 [Warning] \(URL(fileURLWithPath: #file).lastPathComponent):35 \(#function) unique id session id [DEFAULT] warning <REDACTED>",
            "🟩 [Info] \(URL(fileURLWithPath: #file).lastPathComponent):36 \(#function) unique id session id [DEFAULT] info very private information",
            "🧨 🟦 [Debug] \(URL(fileURLWithPath: #file).lastPathComponent):37 \(#function) unique id session id [DEFAULT] debug; halt execution",
            "🟪 [Verbose] \(URL(fileURLWithPath: #file).lastPathComponent):38 \(#function) unique id session id [DEFAULT] verbose <REDACTED>",
            "🟪 [Verbose] \(URL(fileURLWithPath: #file).lastPathComponent):39 \(#function) unique id session id [DEFAULT] verbose veryPrivateInformation"
        ])

        XCTAssertEqual(count, 2)
    }
}
