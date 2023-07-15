extension Value {

    /// Represents a single part of a log message
    ///
    /// A log message is split into multiple segments.
    ///
    /// For example:
    ///
    /// `logger.log(.default(.info, "hello, \(name)"))`
    ///
    /// This log contains 3 segments:
    ///   1. "hello, "
    ///   2. the value of `name`
    ///   3. an empty string to close out the message
    ///
    /// Each segment has an internal and an external representation,
    /// where `internal` usually represents something that should not be sent to 3rd party services and should be contained,
    /// and `external` usually representts something that can be shared publicly without compromise.
    public struct Segment: Equatable {
        var `internal`: String
        var external: String
    }
}
