extension Message {

    /// Initializes a new log message under a default category
    /// - Parameters:
    ///   - level: The level of the log message
    ///   - message: The string of the message, can, contain, multiple, strings
    ///   - file: (Optional) The file containing the log message
    ///   - function: (Optional) The function containing the log message
    ///   - line: (Optional) The line containing the log message
    /// - Returns: A new log message under a default category
    public static func `default`(_ level: Level, _ message: String..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Message {
        .init(
            level: level,
            message: "[DEFAULT] " + message.spaced,
            file: file,
            function: function,
            line: line
        )
    }

    /// Initializes a new log message under an audio category
    /// - Parameters:
    ///   - level: The level of the log message
    ///   - message: The string of the message, can, contain, multiple, strings
    ///   - file: (Optional) The file containing the log message
    ///   - function: (Optional) The function containing the log message
    ///   - line: (Optional) The line containing the log message
    /// - Returns: A new log message under an audio category
    public static func audio(_ level: Level, _ message: String..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Message {
        .init(
            level: level,
            message: "[AUDIO] " + message.spaced,
            file: file,
            function: function,
            line: line
        )
    }

    /// Initializes a new log message under a metrics category
    /// - Parameters:
    ///   - level: The level of the log message
    ///   - message: The string of the message, can, contain, multiple, strings
    ///   - file: (Optional) The file containing the log message
    ///   - function: (Optional) The function containing the log message
    ///   - line: (Optional) The line containing the log message
    /// - Returns: A new log message under a metrics category
    public static func metrics(_ level: Level, _ message: String..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Message {
        .init(
            level: level,
            message: "[METRICS] " + message.spaced,
            file: file,
            function: function,
            line: line
        )
    }

    /// Initializes a new log message under a default category
    /// - Parameters:
    ///   - level: The level of the log message
    ///   - message: The string of the message, can, contain, multiple, strings
    ///   - file: (Optional) The file containing the log message
    ///   - function: (Optional) The function containing the log message
    ///   - line: (Optional) The line containing the log message
    /// - Returns: A new log message under a default category
    public static func network(_ level: Level, _ message: String..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Message {
        .init(
            level: level,
            message: "[NETWORK] " + message.spaced,
            file: file,
            function: function,
            line: line
        )
    }

    /// Initializes a new log message under an operation category
    /// - Parameters:
    ///   - level: The level of the log message
    ///   - message: The string of the message, can, contain, multiple, strings
    ///   - file: (Optional) The file containing the log message
    ///   - function: (Optional) The function containing the log message
    ///   - line: (Optional) The line containing the log message
    /// - Returns: A new log message under an operation category
    public static func operation(_ level: Level, _ message: String..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Message {
        .init(
            level: level,
            message: "[OPERATION] " + message.spaced,
            file: file,
            function: function,
            line: line
        )
    }

    /// Initializes a new log message under a persistence category
    /// - Parameters:
    ///   - level: The level of the log message
    ///   - message: The string of the message, can, contain, multiple, strings
    ///   - file: (Optional) The file containing the log message
    ///   - function: (Optional) The function containing the log message
    ///   - line: (Optional) The line containing the log message
    /// - Returns: A new log message under a persistence category
    public static func persistence(_ level: Level, _ message: String..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Message {
        .init(
            level: level,
            message: "[PERSISTENCE] " + message.spaced,
            file: file,
            function: function,
            line: line
        )
    }

    /// Initializes a new log message under a UI category
    /// - Parameters:
    ///   - level: The level of the log message
    ///   - message: The string of the message, can, contain, multiple, strings
    ///   - file: (Optional) The file containing the log message
    ///   - function: (Optional) The function containing the log message
    ///   - line: (Optional) The line containing the log message
    /// - Returns: A new log message under a UI category
    public static func ui(_ level: Level, _ message: String..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Message {
        .init(
            level: level,
            message: "[UI] " + message.spaced,
            file: file,
            function: function,
            line: line
        )
    }

    /// Initializes a new log message under a video category
    /// - Parameters:
    ///   - level: The level of the log message
    ///   - message: The string of the message, can, contain, multiple, strings
    ///   - file: (Optional) The file containing the log message
    ///   - function: (Optional) The function containing the log message
    ///   - line: (Optional) The line containing the log message
    /// - Returns: A new log message under a video category
    public static func video(_ level: Level, _ message: String..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Message {
        .init(
            level: level,
            message: "[VIDEO] " + message.spaced,
            file: file,
            function: function,
            line: line
        )
    }
}
