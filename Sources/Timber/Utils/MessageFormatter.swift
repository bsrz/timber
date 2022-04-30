import Foundation

enum MessageFormatter {

    /// Formats a log message according to timber standards
    /// - Parameters:
    ///   - message: The message to format
    ///   - config: The config used in the message format
    ///   - execution: The execution used in the mesage format
    /// - Returns: A formatted message as a string
    static func format(message: Message, config: Configuration, execution: Execution) -> String {
        let filename = URL(fileURLWithPath: message.file.description).lastPathComponent
        let msg: [String?] = [
            execution == .halt ? "🧨" : nil,
            message.level.name,
            "\(filename):\(message.line)",
            message.function.description,
            config.uniqueId?(),
            config.sessionId?(),
            message.message
        ]

        return msg
            .compactMap { $0 }
            .spaced
    }
}
