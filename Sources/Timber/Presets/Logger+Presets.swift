extension Logger {

    /// A preset timber logger for getting up and running quickly
    ///
    /// Uses the timber preset destination.
    public static let timber: Logger = .init(
        config: .init(
            destinations: [.timber]
        )
    )

    /// A preset used for testing for when you have a dependency on a logger instance but don't want to log anything
    public static let noop: Logger = .init(config: .init(destinations: []))
}
