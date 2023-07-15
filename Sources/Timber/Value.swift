/// A value represents the core "thing" to log in a message.
///
/// This can be string, an int, or anything that conforms to `ValueConvertible`
public struct Value: Equatable {

    /// An internal representation of the value
    public var `internal`: String { segments.map(\.internal).joined() }

    /// An external representation of the value
    public var external: String { segments.map(\.external).joined() }

    /// An array of all segments in this value
    var segments: [Segment]

    /// Flattens all the segments into a single segment
    /// - Returns: A flatenned version of this `Value`
    func flatten() -> Value {
        Value(segments: [
            Segment(internal: `internal`, external: external)
        ])
    }
}
