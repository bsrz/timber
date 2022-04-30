extension Logger {

    /// A preset timber logger for getting up and running quickly
    ///
    /// Uses the timber preset destination.
    public static let timber: Logger = .init(
        config: .init(
            destinations: [.timber]
        )
    )
}
