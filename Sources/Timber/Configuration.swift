/// An object used to configure the logger
///
/// Contains a list of destinations as well as a function to obtain a unique identifier,
/// and another to obtain a session identifier.
public struct Configuration {

    public typealias SessionID = () -> String?
    public typealias UniqueID = () -> String?

    /// A dictionary of key:value pairs that will be sent to each destination and can be used as needed
    ///
    /// For example, you may decide to use `userConsented:true|false` in order to filter out log messages from certain destinations.
    public var attributes: [Key: CustomStringConvertible?]

    /// An array of destinations
    public var destinations: [Destination]

    /// A function that returns a session identifier
    public var sessionId: SessionID? = nil

    /// A function that returns a unique identifier
    public var uniqueId: UniqueID? = nil

    /// Initalizes a new configuration
    /// - Parameters:
    ///   - destinations: An array containing all destinations the logger should be sending logs to
    ///   - sessionId: An optional function that returns session identifier
    ///   - uniqueId: An optional function that returns a unique identifier
    public init(destinations: [Destination], sessionId: SessionID? = nil, uniqueId: UniqueID? = nil, attributes: [Key: CustomStringConvertible?] = [:]) {
        self.attributes = attributes
        self.destinations = destinations
        self.sessionId = sessionId
        self.uniqueId = uniqueId
    }
}
