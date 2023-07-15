import Algorithms

extension Array where Element == String {

    /// A string representation containing all elements separated with a space
    var spaced: String { joined(separator: " ") }
}

extension Array where Element == Value {

    /// Joins multiple values together
    /// - Parameter separator: The separator to use between values
    /// - Returns: A value representing a flatenned version of all values in the array
    public func joined(separator: String = "") -> Value {
        let flattened = map { $0.flatten() }
        let separator = Value(segments: [.init(internal: separator, external: separator)])
        let interspersed = flattened.interspersed(with: separator)

        return .init(segments: interspersed.flatMap(\.segments))
    }
}
