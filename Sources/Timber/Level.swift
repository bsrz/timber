/// A type representing the level of a log message
///
/// e.g. error, warning, info, debug, verbose
public struct Level {

    /// A double value used for comparing levels
    ///
    /// For example, when using 3 level:
    ///   - verbose level 0
    ///   - warning level 1
    ///   - error level 2
    ///
    /// The destination can choose to ignore all messages with a level lower than 2; meaning it will be logging only errors.
    public var value: Double

    /// A string representation of the level
    ///
    /// The name can be used during message formatting, it can also be used to filter the Xcode console.
    /// e.g. show only log message containing `[error]`
    public var name: String

    /// Initializes a new log level
    /// - Parameters:
    ///   - value: The value of the level
    ///   - name: The name of the level
    public init(value: Double, name: String) {
        self.value = value
        self.name = name
    }
}

extension Level: Comparable {
    public static func < (lhs: Level, rhs: Level) -> Bool {
        return lhs.value < rhs.value
    }
}
