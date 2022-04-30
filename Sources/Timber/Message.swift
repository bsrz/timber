/// A type representing a log message
public struct Message {

    /// The level of the message
    public var level: Level

    /// The string representation of the message
    public var message: String

    /// The file containing the message
    public var file: StaticString

    /// The function containing the message
    public var function: StaticString

    /// The line containing the message
    public var line: UInt

    /// Initializes a new log message
    /// - Parameters:
    ///   - level: The level of the message
    ///   - message: The string representation of the message
    ///   - file: The file containing the message
    ///   - function: The function containing the message
    ///   - line: The line containing the message
    public init(level: Level, message: String, file: StaticString, function: StaticString, line: UInt) {
        self.level = level
        self.message = message
        self.file = file
        self.function = function
        self.line = line
    }
}
