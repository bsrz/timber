import Foundation

public enum MessageFormatter {

    /// Formats a log message according to timber standards
    /// - Parameters:
    ///   - message: The message to format
    ///   - config: The config used in the message format
    ///   - execution: The execution used in the mesage format
    /// - Returns: A formatted message as a string
    public static func format(message: Message, config: Configuration, execution: Execution) -> String {
        let filename = URL(fileURLWithPath: message.file.description).lastPathComponent
        let msg: [String?] = [
            execution.rawValue.isEmpty ? nil : execution.rawValue,
            message.level.name,
            "\(filename):\(message.line)",
            message.function.description,
            config.uniqueId?(),
            config.sessionId?(),
            "\(message.value.external)"
        ]

        return msg
            .compactMap { $0 }
            .spaced
    }
}
