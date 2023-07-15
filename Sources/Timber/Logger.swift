import Foundation

/// A type used to log messages
///
/// The logger holds the configuration to pass down to all destinations.
/// It also holds the precondition function to use to handle program execution.
public class Logger: ObservableObject {

    public typealias Precondition = (@autoclosure () -> Bool, @autoclosure () -> String, StaticString, UInt) -> ()

    /// The configuration to pass down to all destinations
    public let config: Configuration

    /// The precondition function used to evaluate the execution condition when logging a message
    private let precondition: Precondition

    /// Initializes a new logger instance
    /// - Parameters:
    ///   - config: The configuration to pass down to all destinations
    ///   - precondition: The precondition function used to evaluate the execution condition when logging a message
    public init(config: Configuration, precondition: @escaping Precondition = Swift.precondition) {
        self.config = config
        self.precondition = precondition
    }

    /// Logs a message to all destinations
    /// - Parameters:
    ///   - message: The message to log
    ///   - execution: The execution condition to validate after the message is logged
    public func log(_ message: Message, execution: Execution = .continue) {
        config.destinations.forEach {
            $0.send(message, config, execution)
        }

        precondition(execution == .continue, ["🧨", message.value.internal].spaced, message.file, message.line)
    }

    /// Flushes all destinations
    ///
    /// This gives an opportunity to each destination to handle certain actions, such as the app being terminated,
    /// or going into the background.
    ///
    /// For example, you might have a destination that caches all the logs and send one single request to the server
    /// when the app goes into the background. Calling `logger.flush()` when the app goes into the background gives the
    /// destination the opportunity to do so.
    public func flush() {
        config.destinations
            .compactMap { $0.flush }
            .forEach { $0() }
    }
}
