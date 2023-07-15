extension Level {

    /// A level representing verbose log messages
    public static var verbose: Level { return .init(value: 0, name: "🟪 [Verbose]") }

    /// A level representing debug log messages
    public static var debug: Level { return .init(value: 1, name: "🟦 [Debug]") }

    /// A level representing info log messages
    public static var info: Level { return .init(value: 2, name: "🟩 [Info]") }

    /// A level representing warning log messages
    public static var warning: Level { return .init(value: 3, name: "🟨 [Warning]") }

    /// A level representing error log messages
    public static var error: Level { return .init(value: 4, name: "🟥 [Error]") }
}
